import 'package:flutter/material.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/features/calendar/components/pill_sheet_modified_history/components/core/day.dart';
import 'package:pilll/features/calendar/components/pill_sheet_modified_history/components/core/effective_pill_number.dart';
import 'package:pilll/features/calendar/components/pill_sheet_modified_history/components/core/row_layout.dart';

class PillSheetModifiedHistoryDeletedPillSheetAction extends StatelessWidget {
  final DateTime estimatedEventCausingDate;
  final List<String>? pillSheetIDs;

  const PillSheetModifiedHistoryDeletedPillSheetAction({
    Key? key,
    required this.estimatedEventCausingDate,
    required this.pillSheetIDs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowLayout(
      day: Day(estimatedEventCausingDate: estimatedEventCausingDate),
      pillNumbersOrHyphen: PillNumber(pillNumber: PillSheetModifiedHistoryPillNumberOrDate.pillSheetCount(pillSheetIDs ?? [])),
      detail: const Text(
        "ピルシート破棄",
        style: TextStyle(
          color: TextColor.main,
          fontSize: 12,
          fontFamily: FontFamily.japanese,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
