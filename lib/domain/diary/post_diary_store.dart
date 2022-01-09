import 'package:pilll/domain/diary/diary_state.dart';
import 'package:pilll/entity/diary.dart';
import 'package:pilll/service/diary.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostDiaryStore extends StateNotifier<DiaryState> {
  final DiaryService _diaryService;
  PostDiaryStore(this._diaryService, DiaryState state) : super(state);

  void removePhysicalCondition(String physicalCondition) {
    state = state.copyWith(
        diary: state.diary.copyWith(
            physicalConditions: state.diary.physicalConditions
              ..remove(physicalCondition)));
  }

  void addPhysicalCondition(String physicalCondition) {
    state = state.copyWith(
        diary: state.diary.copyWith(
            physicalConditions: state.diary.physicalConditions
              ..add(physicalCondition)));
  }

  void switchingPhysicalCondition(PhysicalConditionStatus status) {
    if (state.hasPhysicalConditionStatusFor(status)) {
      state = state.copyWith(
          diary: state.diary.copyWith(physicalConditionStatus: null));
      return;
    }
    state = state.copyWith(
        diary: state.diary.copyWith(physicalConditionStatus: status));
  }

  void toggleHasSex() {
    state = state.copyWith(
        diary: state.diary.copyWith(hasSex: !state.diary.hasSex));
  }

  void editedMemo(String text) {
    state = state.copyWith(diary: state.diary.copyWith(memo: text));
  }

  Future<Diary> register() {
    return _diaryService.register(state.diary);
  }

  Future<void> delete() {
    return _diaryService.delete(state.diary);
  }
}