import 'package:pilll/entity/firestore_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilll/entity/pill_sheet_type.dart';
import 'package:pilll/utils/datetime/date_compare.dart';
import 'package:pilll/utils/datetime/day.dart';

part 'pill.codegen.g.dart';
part 'pill.codegen.freezed.dart';

@freezed
class PillTaken with _$PillTaken {
  @JsonSerializable(explicitToJson: true)
  const factory PillTaken({
    // 同時服用を行った場合は対象となるPillTakenのrecordedTakenDateTimeは同一にする
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
    required DateTime recordedTakenDateTime,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
    required DateTime createdDateTime,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
    required DateTime updatedDateTime,
    // backendで自動的に記録された場合にtrue
    @Default(false) bool isAutomaticallyRecorded,
  }) = _PillTaken;

  factory PillTaken.fromJson(Map<String, dynamic> json) => _$PillTakenFromJson(json);
}

@freezed
class Pill with _$Pill {
  const Pill._();
  @JsonSerializable(explicitToJson: true)
  const factory Pill(
      {required int index,
      @JsonKey(
        fromJson: NonNullTimestampConverter.timestampToDateTime,
        toJson: NonNullTimestampConverter.dateTimeToTimestamp,
      )
      required DateTime createdDateTime,
      @JsonKey(
        fromJson: NonNullTimestampConverter.timestampToDateTime,
        toJson: NonNullTimestampConverter.dateTimeToTimestamp,
      )
      required DateTime updatedDateTime,
      required List<PillTaken> pillTakens}) = _Pill;

  factory Pill.fromJson(Map<String, dynamic> json) => _$PillFromJson(json);

  static List<Pill> generateAndFillTo({
    required PillSheetType pillSheetType,
    required DateTime fromDate,
    required DateTime? lastTakenDate,
    required int pillTakenCount,
  }) {
    return List.generate(pillSheetType.totalCount, (index) {
      final date = fromDate.add(Duration(days: index));
      return Pill(
        index: index,
        createdDateTime: now(),
        updatedDateTime: now(),
        pillTakens: lastTakenDate != null && (date.isBefore(lastTakenDate) || isSameDay(date, lastTakenDate))
            ? List.generate(
                pillTakenCount,
                (i) {
                  // ピルは複数飲む場合もあるので、dateでtakenDateTimeを更新するのではなく、引数でもらったlastTakenDateを使って値を埋める
                  return PillTaken(
                    recordedTakenDateTime: lastTakenDate,
                    createdDateTime: now(),
                    updatedDateTime: now(),
                  );
                },
              )
            : [],
      );
    });
  }

  @visibleForTesting
  static List<Pill> testGenerateAndIterateTo({
    required PillSheetType pillSheetType,
    required DateTime fromDate,
    required DateTime? lastTakenDate,
    required int pillTakenCount,
  }) {
    return List.generate(pillSheetType.totalCount, (index) {
      final date = fromDate.add(Duration(days: index));
      return Pill(
        index: index,
        createdDateTime: now(),
        updatedDateTime: now(),
        pillTakens: lastTakenDate != null && (date.isBefore(lastTakenDate) || isSameDay(date, lastTakenDate))
            ? List.generate(
                pillTakenCount,
                (i) {
                  // generateAndFillToとの違いはここになる。lastTakenDateではなく、そのピルが通常服用する予定だった服用日がtakenDateTimeにセットされる
                  return PillTaken(
                    recordedTakenDateTime: date,
                    createdDateTime: now(),
                    updatedDateTime: now(),
                  );
                },
              )
            : [],
      );
    });
  }
}
