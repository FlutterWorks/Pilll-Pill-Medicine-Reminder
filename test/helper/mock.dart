import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/database/batch.dart';
import 'package:pilll/domain/calendar/calendar_page_async_action.dart';
import 'package:pilll/domain/menstruation/menstruation_page_async_action.dart';
import 'package:pilll/domain/menstruation_edit/menstruation_edit_page_async_action.dart';
import 'package:pilll/domain/premium_introduction/premium_introduction_store.dart';
import 'package:pilll/domain/record/components/notification_bar/notification_bar_store.dart';
import 'package:pilll/domain/record/record_page_async_action.dart';
import 'package:pilll/domain/record/record_page_store.dart';
import 'package:pilll/domain/settings/setting_page_async_action.dart';
import 'package:pilll/service/auth.dart';
import 'package:pilll/database/diary.dart';
import 'package:pilll/database/menstruation.dart';
import 'package:pilll/database/pill_sheet.dart';
import 'package:pilll/database/pill_sheet_group.dart';
import 'package:pilll/database/pill_sheet_modified_history.dart';
import 'package:pilll/database/setting.dart';
import 'package:pilll/service/day.dart';
import 'package:pilll/database/user.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  PillSheetDatastore,
  TodayService,
  SettingDatastore,
  Analytics,
  DiaryDatastore,
  MenstruationDatastore,
  AuthService,
  UserDatastore,
  RecordPageStore,
  NotificationBarStateStore,
  PremiumIntroductionStore,
  PillSheetModifiedHistoryDatastore,
  PillSheetGroupDatastore,
  BatchFactory,
  WriteBatch,
  RecordPageAsyncAction,
  SettingPageAsyncAction,
  MenstruationPageAsyncAction,
  MenstruationEditPageAsyncAction,
  CalendarPageAsyncAction,
])
abstract class KeepGeneratedMocks {}
