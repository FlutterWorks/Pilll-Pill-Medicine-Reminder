import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/organisms/setting/setting_menstruation_page.dart';
import 'package:pilll/domain/settings/setting_page_store.dart';
import 'package:pilll/entity/setting.dart';
import 'package:pilll/entity/pill_sheet_type.dart';

class MenstruationRow extends HookWidget {
  final Setting setting;

  MenstruationRow(this.setting);

  @override
  Widget build(BuildContext context) {
    final store = useProvider(settingStoreProvider);
    return ListTile(
      title: Row(
        children: [
          Text("生理について", style: FontType.listRow),
          SizedBox(width: 8),
          if (_hasError)
            SvgPicture.asset("images/alert_24.svg", width: 24, height: 24),
        ],
      ),
      subtitle: _hasError
          ? Text("生理開始日のピル番号をご確認ください。現在選択しているピルシートタイプには存在しないピル番号が設定されています")
          : null,
      onTap: () {
        analytics.logEvent(
          name: "did_select_changing_about_menstruation",
        );
        Navigator.of(context).push(SettingMenstruationPageRoute.route(
          done: null,
          doneText: null,
          title: "生理について",
          pillSheetTotalCount: setting.pillSheetType.totalCount,
          model: SettingMenstruationPageModel(
            selectedFromMenstruation: setting.pillNumberForFromMenstruation,
            selectedDurationMenstruation: setting.durationMenstruation,
            pillSheetType: setting.pillSheetType,
          ),
          fromMenstructionDidDecide: (selectedFromMenstruction) =>
              store.modifyFromMenstruation(selectedFromMenstruction),
          durationMenstructionDidDecide: (selectedDurationMenstruation) =>
              store.modifyDurationMenstruation(selectedDurationMenstruation),
        ));
      },
    );
  }

  bool get _hasError {
    return setting.pillSheetType.totalCount <
        setting.pillNumberForFromMenstruation;
  }
}