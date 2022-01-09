import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/domain/settings/setting_page_store.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/entity/setting.dart';
import 'package:pilll/error/error_alert.dart';

class ReminderNotificationCustomizeWordPage extends HookConsumerWidget {
  final Setting setting;
  ReminderNotificationCustomizeWordPage(this.setting);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(settingStoreProvider.notifier);
    final textFieldControlelr = useTextEditingController(
        text: setting.reminderNotificationCustomization.word);
    final word = useState(setting.reminderNotificationCustomization.word);

    return Scaffold(
      backgroundColor: PilllColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "服用通知のカスタマイズ",
          style: TextStyle(
            color: TextColor.black,
          ),
        ),
        backgroundColor: PilllColors.background,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ReminderPushNotificationPreview(word: word.value),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: PilllColors.primary),
                        ),
                        counter: Row(children: [
                          Text(
                            "通知の先頭部分の変更ができます",
                            style: TextStyle(
                                fontFamily: FontFamily.japanese,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: TextColor.darkGray),
                          ),
                          Spacer(),
                          Text(
                            "${word.value.characters.length}/8",
                            style: TextStyle(
                                fontFamily: FontFamily.japanese,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: TextColor.darkGray),
                          ),
                        ]),
                      ),
                      autofocus: true,
                      onChanged: (_word) {
                        word.value = _word;
                      },
                      onSubmitted: (word) async {
                        try {
                          await store.reminderNotificationWordSubmit(word);
                          Navigator.of(context).pop();
                        } catch (error) {
                          showErrorAlert(context, message: error.toString());
                        }
                      },
                      controller: textFieldControlelr,
                      maxLength: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ReminderNotificationCustomizeWordPageRoutes
    on ReminderNotificationCustomizeWordPage {
  static Route<dynamic> route({required Setting setting}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: "ReminderNotificationCustomizeWordPage"),
      builder: (_) => ReminderNotificationCustomizeWordPage(setting),
    );
  }
}

class _ReminderPushNotificationPreview extends StatelessWidget {
  final String word;

  const _ReminderPushNotificationPreview({Key? key, required this.word})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Column(children: [
        Row(children: [
          SvgPicture.asset("images/pilll_icon.svg"),
          SizedBox(width: 8),
          Text(
            "Pilll",
            style: TextStyle(
              fontFamily: FontFamily.japanese,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: TextColor.lightGray2,
            ),
          ),
        ]),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              "$word 1/7 5番",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.japanese,
                color: TextColor.black,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}