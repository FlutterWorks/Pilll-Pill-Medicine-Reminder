import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/domain/record/components/notification_bar/notification_bar_store.dart';
import 'package:pilll/domain/record/components/notification_bar/premium_trial_guide.dart';
import 'package:pilll/domain/record/components/notification_bar/premium_trial_limit.dart';
import 'package:pilll/domain/record/components/notification_bar/recommend_signup.dart';
import 'package:pilll/domain/record/components/notification_bar/recommend_signup_premium.dart';
import 'package:pilll/domain/record/components/notification_bar/rest_duration.dart';
import 'package:pilll/domain/record/record_page_state.dart';

class NotificationBar extends HookWidget {
  final RecordPageState parameter;

  NotificationBar(this.parameter);
  @override
  Widget build(BuildContext context) {
    final body = _body(context);
    if (body != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        color: PilllColors.secondary,
        child: body,
      );
    }

    return Container();
  }

  Widget? _body(BuildContext context) {
    final state = useProvider(notificationBarStateProvider(parameter));
    if (!state.isPremium) {
      final restDurationNotification = state.restDurationNotification;
      if (restDurationNotification != null) {
        return RestDurationNotificationBar(
            restDurationNotification: restDurationNotification);
      }

      if (!state.isLinkedLoginProvider) {
        if (state.totalCountOfActionForTakenPill >= 7) {
          if (!state.recommendedSignupNotificationIsAlreadyShow) {
            return RecommendSignupNotificationBar(parameter: parameter);
          }
        }
      }

      if (!state.isTrial) {
        if (state.trialDeadlineDate == null) {
          if (!state.premiumTrialGuideNotificationIsClosed) {
            return PremiumTrialGuideNotificationBar(parameter: parameter);
          }
        }
      }

      final premiumTrialLimit = state.premiumTrialLimit;
      if (premiumTrialLimit != null) {
        return PremiumTrialLimitNotificationBar(
            premiumTrialLimit: premiumTrialLimit);
      }
    } else {
      if (state.shownRecommendSignupNotificationForPremium) {
        return RecommendSignupForPremiumNotificationBar();
      }

      final restDurationNotification = state.restDurationNotification;
      if (restDurationNotification != null) {
        return RestDurationNotificationBar(
            restDurationNotification: restDurationNotification);
      }
    }
  }
}
