import 'package:flutter_svg/flutter_svg.dart';
import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/buttons.dart';
import 'package:pilll/components/molecules/indicator.dart';
import 'package:pilll/domain/calendar/calendar_card.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/domain/calendar/calendar_help.dart';
import 'package:pilll/store/calendar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

abstract class CalendarPageConstants {
  static final double halfCircleHeight = 300;
}

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(calendarPageStateProvider.state);
    final store = useProvider(calendarPageStateProvider);
    final settingEntity = state.setting;
    if (state.shouldShowIndicator) {
      return ScaffoldIndicator();
    }
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    itemPositionsListener.itemPositions.addListener(() {
      final index = itemPositionsListener.itemPositions.value.last.index;
      store.updateCurrentCalendarIndex(index);
    });
    final ItemScrollController itemScrollController = ItemScrollController();
    return Scaffold(
      backgroundColor: PilllColors.background,
      appBar: AppBar(
        leading: AppBarTextActionButton(
            onPressed: () {
              store.updateCurrentCalendarIndex(state.todayCalendarIndex);
              itemScrollController.scrollTo(
                  index: state.todayCalendarIndex,
                  duration: Duration(milliseconds: 300));
            },
            text: "今日"),
        actions: [
          IconButton(
            icon: SvgPicture.asset("images/help.svg"),
            onPressed: () {
              analytics.logEvent(name: "pressed_calendar_help");
              showDialog(
                  context: context,
                  builder: (_) {
                    return CalendarHelpPage();
                  });
            },
          ),
        ],
        title: Text(
          state.displayMonth,
          style: TextColorStyle.main.merge(FontType.subTitle),
        ),
        elevation: 0,
        backgroundColor: PilllColors.white,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 444,
              child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                initialScrollIndex: state.currentCalendarIndex,
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                itemCount: state.calendarDataSource.length,
                itemPositionsListener: itemPositionsListener,
                itemBuilder: (context, index) {
                  final date = state.calendarDataSource[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CalendarCard(
                      state: CalendarCardState(
                        date: date,
                        latestPillSheet: state.latestPillSheet,
                        setting: settingEntity,
                        menstruations: state.menstruations,
                        bands: state.bands,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
