import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/buttons.dart';
import 'package:pilll/components/template/setting_menstruation/setting_menstruation_dynamic_description.dart';
import 'package:pilll/components/template/setting_menstruation/setting_menstruation_page_template.dart';
import 'package:pilll/components/template/setting_menstruation/setting_menstruation_pill_sheet_list.dart';
import 'package:pilll/domain/initial_setting/reminder_times/initial_setting_reminder_times_page.dart';
import 'package:pilll/domain/initial_setting/initial_setting_store.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/entity/setting.dart';

class InitialSettingMenstruationPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(initialSettingStoreProvider.notifier);
    final state = ref.watch(initialSettingStoreProvider);

    return SettingMenstruationPageTemplate(
      title: "3/4",
      pillSheetList: SettingMenstruationPillSheetList(
        pillSheetTypes: state.pillSheetTypes,
        appearanceMode: PillSheetAppearanceMode.sequential,
        selectedPillNumber: (pageIndex) =>
            store.retrieveMenstruationSelectedPillNumber(pageIndex),
        markSelected: (pageIndex, number) {
          analytics.logEvent(
              name: "from_menstruation_initial_setting",
              parameters: {"number": number, "page": pageIndex});
          store.setFromMenstruation(
              pageIndex: pageIndex, fromMenstruation: number);
        },
      ),
      doneButton: PrimaryButton(
        onPressed: () async {
          analytics.logEvent(name: "done_on_initial_setting_menstruation");
          Navigator.of(context)
              .push(InitialSettingReminderTimesPageRoute.route());
        },
        text: "次へ",
      ),
      dynamicDescription: SettingMenstruationDynamicDescription(
        pillSheetTypes: state.pillSheetTypes,
        fromMenstruation: state.fromMenstruation,
        fromMenstructionDidDecide: (number) {
          analytics.logEvent(
              name: "from_menstruation_initial_setting",
              parameters: {"number": number});
          store.pickFromMenstruation(serializedPillNumberIntoGroup: number);
        },
        durationMenstruation: state.durationMenstruation,
        durationMenstructionDidDecide: (number) {
          analytics.logEvent(
              name: "duration_menstruation_initial_setting",
              parameters: {
                "number": number,
              });
          store.setDurationMenstruation(durationMenstruation: number);
        },
      ),
    );
  }
}

extension InitialSettingMenstruationPageRoute
    on InitialSettingMenstruationPage {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: "InitialSettingMenstruationPage"),
      builder: (_) => InitialSettingMenstruationPage(),
    );
  }
}
