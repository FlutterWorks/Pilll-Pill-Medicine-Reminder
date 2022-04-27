import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pilll/domain/menstruation_list/menstruation_list_row.dart';
import 'package:pilll/domain/menstruation_list/menstruation_list_state.codegen.dart';
import 'package:pilll/database/menstruation.dart';
import 'package:pilll/domain/menstruation/menstruation_store.dart';

final menstruationListStoreProvider =
    StateNotifierProvider<MenstruationListStore, MenstruationListState>(
  (ref) => MenstruationListStore(
    menstruationService: ref.watch(menstruationServiceProvider),
  ),
);

class MenstruationListStore extends StateNotifier<MenstruationListState> {
  final MenstruationService menstruationService;
  MenstruationListStore({
    required this.menstruationService,
  }) : super(const MenstruationListState()) {
    _reset();
  }

  void _reset() {
    Future(() async {
      final menstruations = await menstruationService.fetchAll();
      state = state.copyWith(
        isNotYetLoaded: false,
        allRows: MenstruationListRowState.rows(
            dropInTheMiddleMenstruation(menstruations)),
      );
      _subscribe();
    });
  }

  StreamSubscription? _menstruationCanceller;
  void _subscribe() {
    _menstruationCanceller?.cancel();
    _menstruationCanceller = menstruationService.streamAll().listen((entities) {
      state = state.copyWith(
          allRows: MenstruationListRowState.rows(
              dropInTheMiddleMenstruation(entities)));
    });
  }

  @override
  void dispose() {
    _menstruationCanceller?.cancel();
    super.dispose();
  }
}
