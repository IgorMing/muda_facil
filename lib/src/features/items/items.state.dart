import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.service.dart';

abstract class ListState {
  final itemsService = ItemsService();

  void subscribe();
  void unsubscribe();
}

class AutocompleteListState extends StateNotifier<List<String>> with ListState {
  AutocompleteListState() : super([]);

  late final StreamSubscription _subscription;

  @override
  subscribe() {
    _subscription = itemsService.listStream.listen((event) {
      if (event == null) return;

      state = event.data;
    });
  }

  @override
  unsubscribe() {
    _subscription.cancel();
  }
}

class CandidatesListState extends StateNotifier<List<String>> with ListState {
  CandidatesListState() : super([]);

  late StreamSubscription _subscription;

  @override
  subscribe() {
    _subscription = itemsService.candidatesStream.listen((event) {
      if (event == null) return;

      state = event.data;
    });
  }

  @override
  unsubscribe() {
    _subscription.cancel();
  }
}
