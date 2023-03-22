import 'package:intl/intl.dart';
import 'package:muda_facil/src/models/item.dart';

class GeneralUtils {
  static String formatDateFromTimestamp(int value) {
    return DateFormat('dd/MM/yyyy')
        .format(DateTime.fromMicrosecondsSinceEpoch(value));
  }

  static bool isFilled(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isFilledArray(List? list) {
    return list != null && list.isNotEmpty;
  }

  static String getFormattedItems(List<Item> items) {
    final strItems = items.fold<String>(
      '',
      (previousValue, element) =>
          "$previousValue (${element.amount}) ${element.name}, ",
    );

    return strItems.substring(0, strItems.length - 2);
  }
}
