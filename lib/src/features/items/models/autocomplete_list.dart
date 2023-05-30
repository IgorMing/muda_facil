import 'package:freezed_annotation/freezed_annotation.dart';

part 'autocomplete_list.freezed.dart';
part 'autocomplete_list.g.dart';

@unfreezed
class AutocompleteList with _$AutocompleteList {
  @JsonSerializable(includeIfNull: false)
  factory AutocompleteList({
    required List<String> data,
  }) = _AutocompleteList;

  factory AutocompleteList.fromJson(Map<String, dynamic>? json) =>
      _$AutocompleteListFromJson(json!);
}
