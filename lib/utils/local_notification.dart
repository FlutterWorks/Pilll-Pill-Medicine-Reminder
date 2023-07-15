import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pilll/entity/pill_sheet.codegen.dart';
import 'package:pilll/entity/pill_sheet_group.codegen.dart';
import 'package:pilll/entity/schedule.codegen.dart';
import 'package:pilll/entity/setting.codegen.dart';
import 'package:pilll/entity/weekday.dart';
import 'package:pilll/provider/pill_sheet_group.dart';
import 'package:pilll/provider/premium_and_trial.codegen.dart';
import 'package:pilll/provider/setting.dart';
import 'package:pilll/utils/datetime/day.dart';
import 'package:riverpod/riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// Reminder Notification
const iOSRecordPillActionIdentifier = "RECORD_PILL_LOCAL";
const iOSQuickRecordPillCategoryIdentifier = "PILL_REMINDER_LOCAL";
const androidReminderNotificationChannelID = "androidReminderNotificationChannelID";
const androidCalendarScheduleNotificationChannelID = "androidCalendarScheduleNotificationChannelID";
const androidReminderNotificationActionIdentifier = "androidReminderNotificationActionIdentifier";
const androidReminderNotificationGroupKey = "androidReminderNotificationGroupKey";

// General Android Notification Setting
// Doc: https://developer.android.com/reference/androidx/core/app/NotificationCompat#CATEGORY_REMINDER()
const androidNotificationCategoryCalendarSchedule = "androidNotificationCategoryCalendarSchedule";
const androidNotificationCategoryRemindNotification = "androidNotificationCategoryRemindNotification";

// Notification ID offset
const scheduleNotificationIdentifierOffset = 100000;
const reminderNotificationIdentifierOffset = 1000000000;

// NOTE: It can not be use Future.wait(processes) when register notification.
class LocalNotificationService {
  final plugin = FlutterLocalNotificationsPlugin();

  static Future<void> setupTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
  }

  Future<void> initialize() async {
    await plugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings(
          "ic_notification",
        ),
        iOS: DarwinInitializationSettings(
          notificationCategories: [
            DarwinNotificationCategory(
              iOSQuickRecordPillCategoryIdentifier,
              actions: [
                DarwinNotificationAction.plain(iOSRecordPillActionIdentifier, "飲んだ"),
              ],
            ),
          ],
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        ),
      ),
    );
  }

  Future<void> cancelNotification({required int localNotificationID}) async {
    await plugin.cancel(localNotificationID);
  }

  Future<void> test() async {
    await plugin.zonedSchedule(
      Random().nextInt(1000000),
      'test title',
      'test body',
      tz.TZDateTime.from(now().add(const Duration(minutes: 1)), tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          androidReminderNotificationChannelID,
          "服用通知",
          channelShowBadge: true,
          setAsGroupSummary: true,
          groupKey: androidReminderNotificationGroupKey,
          category: AndroidNotificationCategory("TEST"),
        ),
        iOS: DarwinNotificationDetails(
          categoryIdentifier: iOSQuickRecordPillCategoryIdentifier,
          presentBadge: true,
          sound: "becho.caf",
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

// 必要な状態が全て揃ったら(AsyncData)の時のみ値を返す。そうじゃない場合はnullを返す
final registerReminderLocalNotificationProvider = Provider((ref) {
  final pillSheetGroup = ref.watch(latestPillSheetGroupProvider).asData?.valueOrNull;
  final activePillSheet = ref.watch(activePillSheetProvider).asData?.valueOrNull;
  final premiumAndTrial = ref.watch(premiumAndTrialProvider).asData?.valueOrNull;
  final setting = ref.watch(settingProvider).asData?.valueOrNull;

  if (pillSheetGroup == null || activePillSheet == null || premiumAndTrial == null || setting == null) {
    return null;
  }
  return RegisterReminderLocalNotification(
    pillSheetGroup: pillSheetGroup,
    activePillSheet: activePillSheet,
    premiumOrTrial: premiumAndTrial.premiumOrTrial,
    setting: setting,
  );
});

// Reminder
// 最新の状態を元に更新すれば良いので、更新処理に必要な状態はプロパティで持つ。このプロパティは通常ref.watchにより常に最新に保たれる
// また、状態をcallの引数として受け取らないことで通常はSingle Stateであるものに対して間違った値を受け取れないようにする
// 以下のように行わずに、手続的に必要な箇所でcallを呼ぶ。なぜなら不意にローカル通知の解除や登録が走ってしまうのはアンコントローラブルだから
// - 各アクションと並行して処理を行わない
// - アクションの結果を受け取ってローカル通知の登録の更新をしない
// - 変更を検知してcallを呼ぶ親Widgetを用意して、変更があれば毎回登録しなおす
class RegisterReminderLocalNotification {
  final PillSheetGroup pillSheetGroup;
  final PillSheet activePillSheet;
  final bool premiumOrTrial;
  final Setting setting;

  RegisterReminderLocalNotification({
    required this.pillSheetGroup,
    required this.activePillSheet,
    required this.premiumOrTrial,
    required this.setting,
  });

  // UseCase:
  // - ピルシート追加
  // - 服用記録
  // - 服用キャンセル
  // - クイックレコード
  // - 通知の文言を変えた時
  // - 休薬終了後
  // - 初期設定完了後
  // - 番号変更後
  // - リマインダーの通知がOFF->ONになった時
  // - 久しぶりにアプリを開いたが、通知がスケジュールされていない時
  // - トライアル終了後/プレミアム加入後 → これは服用は続けられているので何もしない。有料機能をしばらく使えてもヨシとする
  // 10日間分の通知をスケジュールする
  Future<void> call() async {
    final tzNow = tz.TZDateTime.now(tz.local);
    final List<Future<void>> futures = [];

    debugPrint("[bannzai] $tzNow, ${tz.local}");

    for (final reminderTime in setting.reminderTimes) {
      // 新規ピルシートグループの作成後に通知のスケジュールができないため、多めに通知をスケジュールする
      // ユーザーの何かしらのアクションでどこかでスケジュールされるだろう
      for (final offset in List.generate(10, (index) => index)) {
        final reminderDate = tzNow.add(Duration(days: offset)).add(Duration(hours: reminderTime.hour)).add(Duration(minutes: reminderTime.minute));
        // NOTE: LocalNotification must be scheduled at least 3 minutes after the current time (in iOS, Android not confirm).
        // Delay five minutes just to be sure.
        if (!reminderDate.add(const Duration(minutes: 5)).isAfter(tzNow)) {
          continue;
        }

        var targetPillSheet = activePillSheet;
        var pillNumberIntoPillSheet = activePillSheet.todayPillNumber + offset;
        if (pillNumberIntoPillSheet > activePillSheet.typeInfo.totalCount) {
          targetPillSheet = pillSheetGroup.pillSheets[activePillSheet.groupIndex + 1];

          const nextPillSheetFirstNumber = 1;
          pillNumberIntoPillSheet = nextPillSheetFirstNumber + offset;
        }

        final notificationID = _calcLocalNotificationID(
            pillSheetGroupIndex: targetPillSheet.groupIndex, reminderTime: reminderTime, pillNumberIntoPillSheet: pillNumberIntoPillSheet);
        if (premiumOrTrial) {
          final title = () {
            var result = setting.reminderNotificationCustomization.word;
            if (!setting.reminderNotificationCustomization.isInVisibleReminderDate) {
              result += " ";
              result += "${reminderDate.month}/${reminderDate.day} (${WeekdayFunctions.weekdayFromDate(reminderDate).weekdayString()})";
            }
            if (!setting.reminderNotificationCustomization.isInVisiblePillNumber) {
              result += " ";
              result += "$pillNumberIntoPillSheet番";
            }
            return result;
          }();

          futures.add(
            Future(() async {
              await localNotificationService.plugin.cancel(notificationID);
              await localNotificationService.plugin.zonedSchedule(
                notificationID,
                title,
                '',
                reminderDate,
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    androidReminderNotificationChannelID,
                    "服用通知",
                    channelShowBadge: true,
                    setAsGroupSummary: true,
                    groupKey: androidReminderNotificationGroupKey,
                    category: AndroidNotificationCategory(androidNotificationCategoryRemindNotification),
                    actions: [
                      AndroidNotificationAction(
                        androidReminderNotificationActionIdentifier,
                        "飲んだ",
                      )
                    ],
                  ),
                  iOS: DarwinNotificationDetails(
                    categoryIdentifier: iOSQuickRecordPillCategoryIdentifier,
                    presentBadge: true,
                    sound: "becho.caf",
                    presentSound: true,
                  ),
                ),
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
              );
            }),
          );
        } else {
          const title = "💊の時間です";
          futures.add(
            Future(() async {
              await localNotificationService.plugin.cancel(notificationID);
              await localNotificationService.plugin.zonedSchedule(
                notificationID,
                title,
                '',
                reminderDate,
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    androidReminderNotificationChannelID,
                    "服用通知",
                    channelShowBadge: true,
                    setAsGroupSummary: true,
                    groupKey: androidReminderNotificationGroupKey,
                    category: AndroidNotificationCategory(androidNotificationCategoryRemindNotification),
                  ),
                  iOS: DarwinNotificationDetails(
                    categoryIdentifier: iOSQuickRecordPillCategoryIdentifier,
                    presentBadge: true,
                    sound: "becho.caf",
                    presentSound: true,
                  ),
                ),
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
              );
            }),
          );
        }
      }
    }

    await Future.wait(futures);

    debugPrint("end scheduleRemiderNotification: ${setting.reminderTimes}");
  }

  // reminder time id is 10{groupIndex:2}{hour:2}{minute:2}{pillNumberIntoPillSheet:2}
  // for example return value 1002223014 means,  `10` is prefix, gropuIndex: `02` is third pillSheet,`22` is hour, `30` is minute, `14` is pill number into pill sheet
  // 1000000000 = reminderNotificationIdentifierOffset
  // 10000000 = pillSheetGroupIndex
  // 100000 = reminderTime.hour
  // 1000 = reminderTime.minute
  // 10 = pillNumberIntoPillSheet
  int _calcLocalNotificationID({
    required int pillSheetGroupIndex,
    required ReminderTime reminderTime,
    required int pillNumberIntoPillSheet,
  }) {
    final groupIndex = pillSheetGroupIndex * 10000000;
    final hour = reminderTime.hour * 100000;
    final minute = reminderTime.minute * 1000;
    return reminderNotificationIdentifierOffset + groupIndex + hour + minute + pillNumberIntoPillSheet;
  }
}

// Schedule
extension ScheduleLocalNotificationService on LocalNotificationService {
  Future<void> scheduleCalendarScheduleNotification({
    required Schedule schedule,
  }) async {
    final localNotification = schedule.localNotification;
    if (localNotification != null) {
      final remindDate = tz.TZDateTime.from(localNotification.remindDateTime, tz.local);
      debugPrint("$remindDate");
      await plugin.zonedSchedule(
        localNotification.localNotificationID,
        "本日の予定です",
        schedule.title,
        remindDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            androidCalendarScheduleNotificationChannelID,
            "カレンダーの予定",
            groupKey: null,
            category: AndroidNotificationCategory(androidNotificationCategoryCalendarSchedule),
          ),
          iOS: DarwinNotificationDetails(
            sound: "becho.caf",
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}

final localNotificationService = LocalNotificationService()..initialize();
