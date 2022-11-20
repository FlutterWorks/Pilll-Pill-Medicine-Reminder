// Mocks generated by Mockito 5.2.0 from annotations
// in pilll/test/helper/mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i16;

import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pilll/entity/diary.codegen.dart' as _i24;
import 'package:pilll/entity/diary_setting.codegen.dart' as _i23;
import 'package:pilll/entity/menstruation.codegen.dart' as _i8;
import 'package:pilll/entity/pill_sheet.codegen.dart' as _i18;
import 'package:pilll/entity/pill_sheet_group.codegen.dart' as _i7;
import 'package:pilll/entity/pill_sheet_modified_history.codegen.dart' as _i19;
import 'package:pilll/entity/pill_sheet_type.dart' as _i17;
import 'package:pilll/entity/pilll_ads.codegen.dart' as _i26;
import 'package:pilll/entity/reminder_notification_customization.codegen.dart'
    as _i5;
import 'package:pilll/entity/schedule.codegen.dart' as _i25;
import 'package:pilll/entity/setting.codegen.dart' as _i6;
import 'package:pilll/entity/user.codegen.dart' as _i22;
import 'package:pilll/provider/batch.dart' as _i10;
import 'package:pilll/provider/database.dart' as _i2;
import 'package:pilll/provider/menstruation.dart' as _i21;
import 'package:pilll/provider/pill_sheet.dart' as _i11;
import 'package:pilll/provider/pill_sheet_group.dart' as _i13;
import 'package:pilll/provider/pill_sheet_modified_history.dart' as _i12;
import 'package:pilll/provider/premium_and_trial.codegen.dart' as _i4;
import 'package:pilll/provider/purchase.dart' as _i28;
import 'package:pilll/provider/revert_take_pill.dart' as _i29;
import 'package:pilll/provider/setting.dart' as _i20;
import 'package:pilll/provider/take_pill.dart' as _i30;
import 'package:pilll/provider/user.dart' as _i27;
import 'package:pilll/utils/analytics.dart' as _i15;
import 'package:pilll/utils/datetime/day.dart' as _i14;
import 'package:purchases_flutter/purchases_flutter.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDateTime_0 extends _i1.Fake implements DateTime {}

class _FakeDatabaseConnection_1 extends _i1.Fake
    implements _i2.DatabaseConnection {}

class _FakeWriteBatch_2 extends _i1.Fake implements _i3.WriteBatch {}

class _Fake$PremiumAndTrialCopyWith_3<$Res> extends _i1.Fake
    implements _i4.$PremiumAndTrialCopyWith<$Res> {}

class _FakeReminderNotificationCustomization_4 extends _i1.Fake
    implements _i5.ReminderNotificationCustomization {}

class _Fake$SettingCopyWith_5<$Res> extends _i1.Fake
    implements _i6.$SettingCopyWith<$Res> {}

class _FakePillSheetGroup_6 extends _i1.Fake implements _i7.PillSheetGroup {}

class _FakeMenstruation_7 extends _i1.Fake implements _i8.Menstruation {}

class _FakeDocumentReference_8<T extends Object?> extends _i1.Fake
    implements _i3.DocumentReference<T> {}

class _FakeCollectionReference_9<T extends Object?> extends _i1.Fake
    implements _i3.CollectionReference<T> {}

class _FakeOfferings_10 extends _i1.Fake implements _i9.Offerings {}

class _FakeBatchFactory_11 extends _i1.Fake implements _i10.BatchFactory {}

class _FakeBatchSetPillSheets_12 extends _i1.Fake
    implements _i11.BatchSetPillSheets {}

class _FakeBatchSetPillSheetModifiedHistory_13 extends _i1.Fake
    implements _i12.BatchSetPillSheetModifiedHistory {}

class _FakeBatchSetPillSheetGroup_14 extends _i1.Fake
    implements _i13.BatchSetPillSheetGroup {}

/// A class which mocks [TodayService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodayService extends _i1.Mock implements _i14.TodayService {
  MockTodayService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  DateTime now() => (super.noSuchMethod(
        Invocation.method(
          #now,
          [],
        ),
        returnValue: _FakeDateTime_0(),
      ) as DateTime);
}

/// A class which mocks [Analytics].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnalytics extends _i1.Mock implements _i15.Analytics {
  MockAnalytics() {
    _i1.throwOnMissingStub(this);
  }

  @override
  dynamic logEvent({
    String? name,
    Map<String, dynamic>? parameters,
  }) =>
      super.noSuchMethod(Invocation.method(
        #logEvent,
        [],
        {
          #name: name,
          #parameters: parameters,
        },
      ));
  @override
  dynamic setCurrentScreen({
    String? screenName,
    String? screenClassOverride = r'Flutter',
  }) =>
      super.noSuchMethod(Invocation.method(
        #setCurrentScreen,
        [],
        {
          #screenName: screenName,
          #screenClassOverride: screenClassOverride,
        },
      ));
  @override
  dynamic setUserProperties(
    String? name,
    dynamic value,
  ) =>
      super.noSuchMethod(Invocation.method(
        #setUserProperties,
        [
          name,
          value,
        ],
      ));
}

/// A class which mocks [BatchFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockBatchFactory extends _i1.Mock implements _i10.BatchFactory {
  MockBatchFactory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i3.WriteBatch batch() => (super.noSuchMethod(
        Invocation.method(
          #batch,
          [],
        ),
        returnValue: _FakeWriteBatch_2(),
      ) as _i3.WriteBatch);
}

/// A class which mocks [WriteBatch].
///
/// See the documentation for Mockito's code generation for more information.
class MockWriteBatch extends _i1.Mock implements _i3.WriteBatch {
  MockWriteBatch() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i16.Future<void> commit() => (super.noSuchMethod(
        Invocation.method(
          #commit,
          [],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as _i16.Future<void>);
  @override
  void delete(_i3.DocumentReference<Object?>? document) => super.noSuchMethod(
        Invocation.method(
          #delete,
          [document],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void set<T>(
    _i3.DocumentReference<T>? document,
    T? data, [
    _i3.SetOptions? options,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #set,
          [
            document,
            data,
            options,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void update(
    _i3.DocumentReference<Object?>? document,
    Map<String, dynamic>? data,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            document,
            data,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PremiumAndTrial].
///
/// See the documentation for Mockito's code generation for more information.
class MockPremiumAndTrial extends _i1.Mock implements _i4.PremiumAndTrial {
  MockPremiumAndTrial() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get trialIsAlreadyBegin => (super.noSuchMethod(
        Invocation.getter(#trialIsAlreadyBegin),
        returnValue: false,
      ) as bool);
  @override
  bool get premiumOrTrial => (super.noSuchMethod(
        Invocation.getter(#premiumOrTrial),
        returnValue: false,
      ) as bool);
  @override
  bool get isNotYetStartTrial => (super.noSuchMethod(
        Invocation.getter(#isNotYetStartTrial),
        returnValue: false,
      ) as bool);
  @override
  bool get isTrial => (super.noSuchMethod(
        Invocation.getter(#isTrial),
        returnValue: false,
      ) as bool);
  @override
  bool get isPremium => (super.noSuchMethod(
        Invocation.getter(#isPremium),
        returnValue: false,
      ) as bool);
  @override
  bool get hasDiscountEntitlement => (super.noSuchMethod(
        Invocation.getter(#hasDiscountEntitlement),
        returnValue: false,
      ) as bool);
  @override
  _i4.$PremiumAndTrialCopyWith<_i4.PremiumAndTrial> get copyWith =>
      (super.noSuchMethod(
        Invocation.getter(#copyWith),
        returnValue: _Fake$PremiumAndTrialCopyWith_3<_i4.PremiumAndTrial>(),
      ) as _i4.$PremiumAndTrialCopyWith<_i4.PremiumAndTrial>);
}

/// A class which mocks [Setting].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetting extends _i1.Mock implements _i6.Setting {
  MockSetting() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i17.PillSheetType> get pillSheetEnumTypes => (super.noSuchMethod(
        Invocation.getter(#pillSheetEnumTypes),
        returnValue: <_i17.PillSheetType>[],
      ) as List<_i17.PillSheetType>);
  @override
  List<_i17.PillSheetType?> get pillSheetTypes => (super.noSuchMethod(
        Invocation.getter(#pillSheetTypes),
        returnValue: <_i17.PillSheetType?>[],
      ) as List<_i17.PillSheetType?>);
  @override
  int get pillNumberForFromMenstruation => (super.noSuchMethod(
        Invocation.getter(#pillNumberForFromMenstruation),
        returnValue: 0,
      ) as int);
  @override
  int get durationMenstruation => (super.noSuchMethod(
        Invocation.getter(#durationMenstruation),
        returnValue: 0,
      ) as int);
  @override
  List<_i6.ReminderTime> get reminderTimes => (super.noSuchMethod(
        Invocation.getter(#reminderTimes),
        returnValue: <_i6.ReminderTime>[],
      ) as List<_i6.ReminderTime>);
  @override
  bool get isOnReminder => (super.noSuchMethod(
        Invocation.getter(#isOnReminder),
        returnValue: false,
      ) as bool);
  @override
  bool get isOnNotifyInNotTakenDuration => (super.noSuchMethod(
        Invocation.getter(#isOnNotifyInNotTakenDuration),
        returnValue: false,
      ) as bool);
  @override
  _i6.PillSheetAppearanceMode get pillSheetAppearanceMode =>
      (super.noSuchMethod(
        Invocation.getter(#pillSheetAppearanceMode),
        returnValue: _i6.PillSheetAppearanceMode.number,
      ) as _i6.PillSheetAppearanceMode);
  @override
  bool get isAutomaticallyCreatePillSheet => (super.noSuchMethod(
        Invocation.getter(#isAutomaticallyCreatePillSheet),
        returnValue: false,
      ) as bool);
  @override
  _i5.ReminderNotificationCustomization get reminderNotificationCustomization =>
      (super.noSuchMethod(
        Invocation.getter(#reminderNotificationCustomization),
        returnValue: _FakeReminderNotificationCustomization_4(),
      ) as _i5.ReminderNotificationCustomization);
  @override
  _i6.$SettingCopyWith<_i6.Setting> get copyWith => (super.noSuchMethod(
        Invocation.getter(#copyWith),
        returnValue: _Fake$SettingCopyWith_5<_i6.Setting>(),
      ) as _i6.$SettingCopyWith<_i6.Setting>);
  @override
  Map<String, dynamic> toJson() => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
}

/// A class which mocks [BatchSetPillSheetGroup].
///
/// See the documentation for Mockito's code generation for more information.
class MockBatchSetPillSheetGroup extends _i1.Mock
    implements _i13.BatchSetPillSheetGroup {
  MockBatchSetPillSheetGroup() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i7.PillSheetGroup call(
    _i3.WriteBatch? batch,
    _i7.PillSheetGroup? pillSheetGroup,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            batch,
            pillSheetGroup,
          ],
        ),
        returnValue: _FakePillSheetGroup_6(),
      ) as _i7.PillSheetGroup);
}

/// A class which mocks [BatchSetPillSheets].
///
/// See the documentation for Mockito's code generation for more information.
class MockBatchSetPillSheets extends _i1.Mock
    implements _i11.BatchSetPillSheets {
  MockBatchSetPillSheets() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  List<_i18.PillSheet> call(
    _i3.WriteBatch? batch,
    List<_i18.PillSheet>? pillSheets,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            batch,
            pillSheets,
          ],
        ),
        returnValue: <_i18.PillSheet>[],
      ) as List<_i18.PillSheet>);
}

/// A class which mocks [BatchSetPillSheetModifiedHistory].
///
/// See the documentation for Mockito's code generation for more information.
class MockBatchSetPillSheetModifiedHistory extends _i1.Mock
    implements _i12.BatchSetPillSheetModifiedHistory {
  MockBatchSetPillSheetModifiedHistory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  void call(
    _i3.WriteBatch? batch,
    _i19.PillSheetModifiedHistory? history,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #call,
          [
            batch,
            history,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [BatchSetSetting].
///
/// See the documentation for Mockito's code generation for more information.
class MockBatchSetSetting extends _i1.Mock implements _i20.BatchSetSetting {
  MockBatchSetSetting() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  void call(
    _i3.WriteBatch? batch,
    _i6.Setting? setting,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #call,
          [
            batch,
            setting,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SetSetting].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetSetting extends _i1.Mock implements _i20.SetSetting {
  MockSetSetting() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<void> call(_i6.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [setting],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as _i16.Future<void>);
}

/// A class which mocks [SetPillSheetGroup].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetPillSheetGroup extends _i1.Mock implements _i13.SetPillSheetGroup {
  MockSetPillSheetGroup() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<void> call(_i7.PillSheetGroup? pillSheetGroup) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [pillSheetGroup],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as _i16.Future<void>);
}

/// A class which mocks [DeleteMenstruation].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteMenstruation extends _i1.Mock
    implements _i21.DeleteMenstruation {
  MockDeleteMenstruation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<void> call(_i8.Menstruation? menstruation) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [menstruation],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as _i16.Future<void>);
}

/// A class which mocks [SetMenstruation].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetMenstruation extends _i1.Mock implements _i21.SetMenstruation {
  MockSetMenstruation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<_i8.Menstruation> call(_i8.Menstruation? _menstruation) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [_menstruation],
        ),
        returnValue: Future<_i8.Menstruation>.value(_FakeMenstruation_7()),
      ) as _i16.Future<_i8.Menstruation>);
}

/// A class which mocks [BeginMenstruation].
///
/// See the documentation for Mockito's code generation for more information.
class MockBeginMenstruation extends _i1.Mock implements _i21.BeginMenstruation {
  MockBeginMenstruation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<_i8.Menstruation> call(
    DateTime? begin, {
    _i6.Setting? setting,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [begin],
          {#setting: setting},
        ),
        returnValue: Future<_i8.Menstruation>.value(_FakeMenstruation_7()),
      ) as _i16.Future<_i8.Menstruation>);
}

/// A class which mocks [DatabaseConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseConnection extends _i1.Mock
    implements _i2.DatabaseConnection {
  MockDatabaseConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get userID => (super.noSuchMethod(
        Invocation.getter(#userID),
        returnValue: '',
      ) as String);
  @override
  _i3.DocumentReference<_i22.User> userReference() => (super.noSuchMethod(
        Invocation.method(
          #userReference,
          [],
        ),
        returnValue: _FakeDocumentReference_8<_i22.User>(),
      ) as _i3.DocumentReference<_i22.User>);
  @override
  _i3.DocumentReference<Object?> userRawReference() => (super.noSuchMethod(
        Invocation.method(
          #userRawReference,
          [],
        ),
        returnValue: _FakeDocumentReference_8<Object?>(),
      ) as _i3.DocumentReference<Object?>);
  @override
  _i3.DocumentReference<_i23.DiarySetting> diarySettingReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #diarySettingReference,
          [],
        ),
        returnValue: _FakeDocumentReference_8<_i23.DiarySetting>(),
      ) as _i3.DocumentReference<_i23.DiarySetting>);
  @override
  _i3.CollectionReference<_i18.PillSheet> pillSheetsReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #pillSheetsReference,
          [],
        ),
        returnValue: _FakeCollectionReference_9<_i18.PillSheet>(),
      ) as _i3.CollectionReference<_i18.PillSheet>);
  @override
  _i3.DocumentReference<_i18.PillSheet> pillSheetReference(
          String? pillSheetID) =>
      (super.noSuchMethod(
        Invocation.method(
          #pillSheetReference,
          [pillSheetID],
        ),
        returnValue: _FakeDocumentReference_8<_i18.PillSheet>(),
      ) as _i3.DocumentReference<_i18.PillSheet>);
  @override
  _i3.CollectionReference<_i24.Diary> diariesReference() => (super.noSuchMethod(
        Invocation.method(
          #diariesReference,
          [],
        ),
        returnValue: _FakeCollectionReference_9<_i24.Diary>(),
      ) as _i3.CollectionReference<_i24.Diary>);
  @override
  _i3.DocumentReference<_i24.Diary> diaryReference(_i24.Diary? diary) =>
      (super.noSuchMethod(
        Invocation.method(
          #diaryReference,
          [diary],
        ),
        returnValue: _FakeDocumentReference_8<_i24.Diary>(),
      ) as _i3.DocumentReference<_i24.Diary>);
  @override
  _i3.DocumentReference<Object?> userPrivateRawReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #userPrivateRawReference,
          [],
        ),
        returnValue: _FakeDocumentReference_8<Object?>(),
      ) as _i3.DocumentReference<Object?>);
  @override
  _i3.CollectionReference<_i8.Menstruation> menstruationsReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #menstruationsReference,
          [],
        ),
        returnValue: _FakeCollectionReference_9<_i8.Menstruation>(),
      ) as _i3.CollectionReference<_i8.Menstruation>);
  @override
  _i3.DocumentReference<_i8.Menstruation> menstruationReference(
          String? menstruationID) =>
      (super.noSuchMethod(
        Invocation.method(
          #menstruationReference,
          [menstruationID],
        ),
        returnValue: _FakeDocumentReference_8<_i8.Menstruation>(),
      ) as _i3.DocumentReference<_i8.Menstruation>);
  @override
  _i3.CollectionReference<_i19.PillSheetModifiedHistory>
      pillSheetModifiedHistoriesReference() => (super.noSuchMethod(
            Invocation.method(
              #pillSheetModifiedHistoriesReference,
              [],
            ),
            returnValue:
                _FakeCollectionReference_9<_i19.PillSheetModifiedHistory>(),
          ) as _i3.CollectionReference<_i19.PillSheetModifiedHistory>);
  @override
  _i3.DocumentReference<_i19.PillSheetModifiedHistory>
      pillSheetModifiedHistoryReference({String? pillSheetModifiedHistoryID}) =>
          (super.noSuchMethod(
            Invocation.method(
              #pillSheetModifiedHistoryReference,
              [],
              {#pillSheetModifiedHistoryID: pillSheetModifiedHistoryID},
            ),
            returnValue:
                _FakeDocumentReference_8<_i19.PillSheetModifiedHistory>(),
          ) as _i3.DocumentReference<_i19.PillSheetModifiedHistory>);
  @override
  _i3.CollectionReference<_i7.PillSheetGroup> pillSheetGroupsReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #pillSheetGroupsReference,
          [],
        ),
        returnValue: _FakeCollectionReference_9<_i7.PillSheetGroup>(),
      ) as _i3.CollectionReference<_i7.PillSheetGroup>);
  @override
  _i3.DocumentReference<_i7.PillSheetGroup> pillSheetGroupReference(
          String? pillSheetGroupID) =>
      (super.noSuchMethod(
        Invocation.method(
          #pillSheetGroupReference,
          [pillSheetGroupID],
        ),
        returnValue: _FakeDocumentReference_8<_i7.PillSheetGroup>(),
      ) as _i3.DocumentReference<_i7.PillSheetGroup>);
  @override
  _i3.CollectionReference<_i25.Schedule> schedulesReference() =>
      (super.noSuchMethod(
        Invocation.method(
          #schedulesReference,
          [],
        ),
        returnValue: _FakeCollectionReference_9<_i25.Schedule>(),
      ) as _i3.CollectionReference<_i25.Schedule>);
  @override
  _i3.DocumentReference<_i25.Schedule> scheduleReference(String? scheduleID) =>
      (super.noSuchMethod(
        Invocation.method(
          #scheduleReference,
          [scheduleID],
        ),
        returnValue: _FakeDocumentReference_8<_i25.Schedule>(),
      ) as _i3.DocumentReference<_i25.Schedule>);
  @override
  _i3.DocumentReference<_i26.PilllAds?> pilllAds() => (super.noSuchMethod(
        Invocation.method(
          #pilllAds,
          [],
        ),
        returnValue: _FakeDocumentReference_8<_i26.PilllAds?>(),
      ) as _i3.DocumentReference<_i26.PilllAds?>);
  @override
  _i16.Future<T> transaction<T>(
          _i3.TransactionHandler<T>? transactionHandler) =>
      (super.noSuchMethod(
        Invocation.method(
          #transaction,
          [transactionHandler],
        ),
        returnValue: Future<T>.value(null),
      ) as _i16.Future<T>);
  @override
  _i3.WriteBatch batch() => (super.noSuchMethod(
        Invocation.method(
          #batch,
          [],
        ),
        returnValue: _FakeWriteBatch_2(),
      ) as _i3.WriteBatch);
}

/// A class which mocks [EndInitialSetting].
///
/// See the documentation for Mockito's code generation for more information.
class MockEndInitialSetting extends _i1.Mock implements _i27.EndInitialSetting {
  MockEndInitialSetting() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseConnection get databaseConnection => (super.noSuchMethod(
        Invocation.getter(#databaseConnection),
        returnValue: _FakeDatabaseConnection_1(),
      ) as _i2.DatabaseConnection);
  @override
  _i16.Future<void> call(_i6.Setting? setting) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [setting],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      ) as _i16.Future<void>);
}

/// A class which mocks [PurchaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPurchaseService extends _i1.Mock implements _i28.PurchaseService {
  MockPurchaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i16.Future<_i9.Offerings> fetchOfferings() => (super.noSuchMethod(
        Invocation.method(
          #fetchOfferings,
          [],
        ),
        returnValue: Future<_i9.Offerings>.value(_FakeOfferings_10()),
      ) as _i16.Future<_i9.Offerings>);
}

/// A class which mocks [RevertTakePill].
///
/// See the documentation for Mockito's code generation for more information.
class MockRevertTakePill extends _i1.Mock implements _i29.RevertTakePill {
  MockRevertTakePill() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.BatchFactory get batchFactory => (super.noSuchMethod(
        Invocation.getter(#batchFactory),
        returnValue: _FakeBatchFactory_11(),
      ) as _i10.BatchFactory);
  @override
  _i11.BatchSetPillSheets get batchSetPillSheets => (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheets),
        returnValue: _FakeBatchSetPillSheets_12(),
      ) as _i11.BatchSetPillSheets);
  @override
  _i12.BatchSetPillSheetModifiedHistory get batchSetPillSheetModifiedHistory =>
      (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheetModifiedHistory),
        returnValue: _FakeBatchSetPillSheetModifiedHistory_13(),
      ) as _i12.BatchSetPillSheetModifiedHistory);
  @override
  _i13.BatchSetPillSheetGroup get batchSetPillSheetGroup => (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheetGroup),
        returnValue: _FakeBatchSetPillSheetGroup_14(),
      ) as _i13.BatchSetPillSheetGroup);
  @override
  _i16.Future<_i7.PillSheetGroup?> call({
    _i7.PillSheetGroup? pillSheetGroup,
    int? pageIndex,
    int? pillNumberIntoPillSheet,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #pillSheetGroup: pillSheetGroup,
            #pageIndex: pageIndex,
            #pillNumberIntoPillSheet: pillNumberIntoPillSheet,
          },
        ),
        returnValue: Future<_i7.PillSheetGroup?>.value(),
      ) as _i16.Future<_i7.PillSheetGroup?>);
}

/// A class which mocks [TakePill].
///
/// See the documentation for Mockito's code generation for more information.
class MockTakePill extends _i1.Mock implements _i30.TakePill {
  MockTakePill() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.BatchFactory get batchFactory => (super.noSuchMethod(
        Invocation.getter(#batchFactory),
        returnValue: _FakeBatchFactory_11(),
      ) as _i10.BatchFactory);
  @override
  _i11.BatchSetPillSheets get batchSetPillSheets => (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheets),
        returnValue: _FakeBatchSetPillSheets_12(),
      ) as _i11.BatchSetPillSheets);
  @override
  _i12.BatchSetPillSheetModifiedHistory get batchSetPillSheetModifiedHistory =>
      (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheetModifiedHistory),
        returnValue: _FakeBatchSetPillSheetModifiedHistory_13(),
      ) as _i12.BatchSetPillSheetModifiedHistory);
  @override
  _i13.BatchSetPillSheetGroup get batchSetPillSheetGroup => (super.noSuchMethod(
        Invocation.getter(#batchSetPillSheetGroup),
        returnValue: _FakeBatchSetPillSheetGroup_14(),
      ) as _i13.BatchSetPillSheetGroup);
  @override
  _i16.Future<_i7.PillSheetGroup?> call({
    DateTime? takenDate,
    _i7.PillSheetGroup? pillSheetGroup,
    _i18.PillSheet? activedPillSheet,
    bool? isQuickRecord,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #takenDate: takenDate,
            #pillSheetGroup: pillSheetGroup,
            #activedPillSheet: activedPillSheet,
            #isQuickRecord: isQuickRecord,
          },
        ),
        returnValue: Future<_i7.PillSheetGroup?>.value(),
      ) as _i16.Future<_i7.PillSheetGroup?>);
}
