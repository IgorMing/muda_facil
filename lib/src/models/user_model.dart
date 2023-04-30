import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muda_facil/src/utils/constants.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(includeIfNull: false)
  factory UserModel({
    String? uid,
    String? email,
    String? name,
    String? phone,
    Role? role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic>? json) =>
      _$UserModelFromJson(json!);

  bool get onboardingCompleted => name != null && phone != null;
}
