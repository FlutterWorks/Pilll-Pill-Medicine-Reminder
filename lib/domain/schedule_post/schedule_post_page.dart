import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/buttons.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/components/molecules/indicator.dart';
import 'package:pilll/database/database.dart';
import 'package:pilll/domain/schedule_post/state.codegen.dart';
import 'package:pilll/entity/schedule.codegen.dart';
import 'package:pilll/error/error_alert.dart';
import 'package:pilll/error/universal_error_page.dart';
import 'package:pilll/service/local_notification.dart';
import 'package:pilll/util/const.dart';
import 'package:pilll/util/formatter/date_time_formatter.dart';
import 'package:pilll/util/datetime/day.dart';

class SchedulePostPage extends HookConsumerWidget {
  final DateTime date;

  const SchedulePostPage({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(schedulePostAsyncStateProvider(date));

    return asyncState.when(
      data: (state) => _SchedulePostPage(state: state),
      error: (error, _) => UniversalErrorPage(
        error: error,
        child: null,
        reload: () => ref.refresh(schedulePostAsyncStateProvider(date)),
      ),
      loading: () => const ScaffoldIndicator(),
    );
  }
}

class _SchedulePostPage extends HookConsumerWidget {
  final SchedulePostState state;

  const _SchedulePostPage({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule =
        state.scheduleOrNull(index: 0) ?? Schedule(title: "", localNotification: null, date: state.date, createdDateTime: DateTime.now());
    final title = useState(schedule.title);
    final isOnRemind = useState(schedule.localNotification != null);
    final textEditingController = useTextEditingController(text: title.value);
    final focusNode = useFocusNode();
    final scrollController = useScrollController();
    isInvalid() => state.date.date().isAfter(today()) || title.value.isEmpty;

    return Scaffold(
      backgroundColor: PilllColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(DateTimeFormatter.yearAndMonthAndDay(state.date), style: FontType.sBigTitle.merge(TextColorStyle.main)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          AlertButton(
            text: "保存",
            onPressed: isInvalid()
                ? () async {
                    analytics.logEvent(name: "schedule_post_pressed");
                    try {
                      final localNotificationID = schedule.localNotification?.localNotificationID;
                      if (localNotificationID != null) {
                        await localNotificationService.cancelNotification(localNotificationID: localNotificationID);
                      }

                      final Schedule newSchedule;
                      if (isOnRemind.value) {
                        newSchedule = schedule.copyWith(
                          title: title.value,
                          localNotification: LocalNotification(
                            localNotificationID: Random().nextInt(scheduleNotificationIdentifierOffset),
                            remindDateTime: DateTime(state.date.year, state.date.month, state.date.day, 9),
                          ),
                        );
                        await localNotificationService.scheduleCalendarScheduleNotification(schedule: newSchedule);
                      } else {
                        newSchedule = schedule.copyWith(
                          title: title.value,
                          localNotification: null,
                        );
                      }

                      await ref.read(databaseProvider).schedulesReference().doc(newSchedule.id).set(
                            newSchedule,
                            SetOptions(merge: true),
                          );
                      Navigator.of(context).pop();
                    } catch (error) {
                      showErrorAlert(context, error);
                    }
                  }
                : null,
          ),
        ],
        backgroundColor: PilllColors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  controller: scrollController,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        maxWidth: MediaQuery.of(context).size.width,
                        minHeight: 40,
                        maxHeight: 200,
                      ),
                      child: TextFormField(
                        onChanged: (text) {
                          title.value = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "通院する",
                          border: OutlineInputBorder(),
                        ),
                        controller: textEditingController,
                        maxLines: null,
                        maxLength: 60,
                        keyboardType: TextInputType.multiline,
                        focusNode: focusNode,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text("当日9:00に通知を受け取る", style: FontType.listRow),
                      activeColor: PilllColors.primary,
                      onChanged: (bool value) {
                        analytics.logEvent(
                          name: "schedule_post_remind_toggle",
                        );
                        isOnRemind.value = value;
                      },
                      value: isOnRemind.value,
                      // NOTE: when configured subtitle, the space between elements becomes very narrow
                      contentPadding: const EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
            if (focusNode.hasFocus) _keyboardToolbar(context, focusNode),
          ],
        ),
      ),
    );
  }

  Widget _keyboardToolbar(BuildContext context, FocusNode focusNode) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      child: Container(
        height: keyboardToolbarHeight,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const Spacer(),
            AlertButton(
              text: '完了',
              onPressed: () async {
                analytics.logEvent(name: "schedule_post_toolbar_done");
                focusNode.unfocus();
              },
            ),
          ],
        ),
        decoration: const BoxDecoration(color: PilllColors.white),
      ),
    );
  }
}

extension SchedulePostPageRoute on SchedulePostPage {
  static Route<dynamic> route(DateTime date) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "SchedulePostPage"),
      builder: (_) => SchedulePostPage(date: date),
      fullscreenDialog: true,
    );
  }
}
