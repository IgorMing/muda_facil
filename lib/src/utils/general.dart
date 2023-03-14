import 'package:intl/intl.dart';

class GeneralUtils {
  static String formatDateFromTimestamp(int value) {
    return DateFormat('dd/MM/yyyy H:m')
        .format(DateTime.fromMicrosecondsSinceEpoch(value));
  }

  static bool isFilled(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isFilledArray(List? list) {
    return list != null && list.isNotEmpty;
  }
}
