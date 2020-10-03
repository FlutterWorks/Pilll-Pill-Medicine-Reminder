import 'package:Pilll/main/calendar/calculator.dart';
import 'package:Pilll/main/calendar/calendar.dart';
import 'package:Pilll/main/calendar/calendar_band_model.dart';
import 'package:Pilll/main/calendar/date_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    WidgetsBinding.instance.renderView.configuration =
        new TestViewConfiguration(size: const Size(375.0, 667.0));
  });
  group("Appearance Next Sheet Label", () {
    testWidgets('when showing 新しいシート開始 ▶︎', (WidgetTester tester) async {
      /*
  30   31   1   2   3   4   5  

   6    7   8   9  10  11  12  

  13   14  15  16  17  18  19  
           ==============
  20   21  22  23  24  25  26  

  27   28  29  30  
    */
      var now = DateTime(2020, 09, 14);
      var model = CalendarNextPillSheetBandModel(
          DateTime(2020, 09, 15), DateTime(2020, 09, 18));
      await tester.pumpWidget(
        MaterialApp(
          home: Calendar(calculator: Calculator(now), bandModels: [model]),
        ),
      );
      expect(find.text("新しいシート開始 ▶︎"), findsOneWidget);
      expect(find.byType(CalendarBand), findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) => (widget is CalendarBand &&
              DateRange.isSameDay(widget.model.begin, model.begin) &&
              DateRange.isSameDay(widget.model.end, model.end))),
          findsOneWidget);
    });
    testWidgets('when showing 新しいシート開始 ▶︎ with linebreak',
        (WidgetTester tester) async {
      /*
  30   31   1   2   3   4   5  

   6    7   8   9  10  11  12  

  13   14  15  16  17  18  19  
                           == 
  20   21  22  23  24  25  26  
  =======
  27   28  29  30  
    */
      var now = DateTime(2020, 09, 14);
      var model = CalendarNextPillSheetBandModel(
          DateTime(2020, 09, 19), DateTime(2020, 09, 21));
      await tester.pumpWidget(
        MaterialApp(
          home: Calendar(calculator: Calculator(now), bandModels: [model]),
        ),
      );
      expect(find.text("新しいシート開始 ▶︎"), findsOneWidget);
      expect(find.byType(CalendarBand), findsNWidgets(2));
      expect(
          find.byWidgetPredicate((widget) => (widget is CalendarBand &&
              DateRange.isSameDay(widget.model.begin, model.begin) &&
              DateRange.isSameDay(widget.model.end, model.end))),
          findsNWidgets(2));
    });
    testWidgets('when showing new sheet label to next month',
        (WidgetTester tester) async {
      var now = DateTime(2020, 09, 14);
      await tester.pumpWidget(
        MaterialApp(
          home: Calendar(calculator: Calculator(now), bandModels: [
            CalendarNextPillSheetBandModel(
                DateTime(2020, 10, 15), DateTime(2020, 10, 18)),
          ]),
        ),
      );
      expect(find.text("新しいシート開始 ▶︎"), isNot(findsWidgets));
      expect(find.byType(CalendarBand), isNot(findsWidgets));
    });
    testWidgets('when showing new sheet label to before month',
        (WidgetTester tester) async {
      var now = DateTime(2020, 09, 14);
      await tester.pumpWidget(
        MaterialApp(
          home: Calendar(calculator: Calculator(now), bandModels: [
            CalendarNextPillSheetBandModel(
                DateTime(2020, 08, 15), DateTime(2020, 08, 18)),
          ]),
        ),
      );
      expect(find.text("新しいシート開始 ▶︎"), isNot(findsWidgets));
      expect(find.byType(CalendarBand), isNot(findsWidgets));
    });
  });
}
