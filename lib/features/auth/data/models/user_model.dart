import 'package:firebase_chat/transformers/models_fields.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? accessToken;
  final String provider;
  final String? providerId;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.accessToken,
    required this.provider,
    required this.providerId,
  });

  static UserModel fromJSON(Map<String, dynamic> obj) {
    return UserModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      accessToken: obj[ModelsFields.accessToken],
      provider: obj[ModelsFields.provider],
      providerId: obj[ModelsFields.providerId],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.accessToken: accessToken,
      ModelsFields.provider: provider,
      ModelsFields.providerId: providerId,
    };
  }
}
