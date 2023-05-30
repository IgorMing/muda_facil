import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/features/items/items.service.dart';

class AutocompleteListState extends StateNotifier<List<String>> {
  AutocompleteListState() : super([]);

  final itemsService = ItemsService();

  late final StreamSubscription _subscription;

  subscribe() {
    _subscription = itemsService.listStream.listen((event) {
      if (event == null) return;

      state = event.data;
    });
  }

  unsubscribe() {
    return _subscription.cancel();
  }
}
