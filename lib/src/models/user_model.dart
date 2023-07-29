import 'package:cloud_firestore/cloud_firestore.dart';
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
    @Default(Role.user) Role role,
  }) = _UserModel;

  factory UserModel.empty() => UserModel(email: '');

  factory UserModel.fromJson(Map<String, dynamic>? json) =>
      _$UserModelFromJson(json!);

  factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel.fromJson(doc.data()).copyWith(uid: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  bool get onboardingCompleted => name != null && phone != null;
}
