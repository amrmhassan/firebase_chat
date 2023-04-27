import 'package:firebase_chat/transformers/models_fields.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  static UserModel fromJSON(Map<String, dynamic> obj) {
    return UserModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
    };
  }
}
