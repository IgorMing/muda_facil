import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/user_model.dart';

extension CustomFirebaseFirestore on FirebaseFirestore {
  CollectionReference<UserModel> userRef() => collection('users').withConverter(
        fromFirestore: (snapshot, options) => UserModel.fromDocument(snapshot),
        toFirestore: (value, _) => value.toDocument(),
      );
}
