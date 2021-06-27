import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/buttons.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:flutter/material.dart';
import 'package:pilll/domain/premium_trial/premium_trial_modal_store.dart';
import 'package:pilll/entity/user_error.dart';
import 'package:pilll/error/error_alert.dart';
import 'package:pilll/util/environment.dart';
import 'package:pilll/util/shared_preference/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumTrialModal extends HookWidget {
  const PremiumTrialModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final store = useProvider(premiumTrialStoreProvider);
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 314,
          height: 360,
          decoration: BoxDecoration(
            color: PilllColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 108,
                            decoration: BoxDecoration(
                              color: PilllColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Center(
                              child: Text(
                                "30日間お試し",
                                style: TextStyle(
                                    color: TextColor.white,
                                    fontFamily: FontFamily.japanese,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "プレミアム体験プレゼント中",
                            style: TextStyle(
                              color: TextColor.black,
                              fontFamily: FontFamily.japanese,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("images/crown.svg"),
                    SizedBox(height: 24),
                    Text(
                      '''
プレミアム機能がお試しできます。
自動で課金される事はありません。
                      ''',
                      style: TextStyle(
                          color: TextColor.black,
                          fontFamily: FontFamily.japanese,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SizedBox(height: 24),
                    PrimaryButton(
                      onPressed: () async {
                        analytics.logEvent(name: "trial_did_pressed");
                        try {
                          await store.trial();
                        } catch (exception) {
                          if (exception is UserDisplayedError) {
                            showErrorAlertWithError(context, exception);
                          } else {
                            store.handleException(exception);
                          }
                        }
                      },
                      text: "ためす",
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

showPremiumTrialModalWhenLaunchApp(BuildContext context) async {
  final key = BoolKey.isAlreadyShowPremiumTrialModal;
  final storage = await SharedPreferences.getInstance();
  if (storage.getBool(key) ?? false) {
    return;
  }
  storage.setBool(key, !Environment.isDevelopment);

  showDialog(
      context: context,
      builder: (context) {
        return PremiumTrialModal();
      });
}
