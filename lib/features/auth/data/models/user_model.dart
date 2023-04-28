import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:firebase_chat/transformers/models_fields.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../transformers/facebook_photo.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? accessToken;
  @HiveField(4)
  final String provider;
  @HiveField(5)
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

  SignProvider get signProvider => SignProvidersGet.get(provider)!;

  Future<String?> get photoUrl async {
    if (signProvider == SignProvider.email) {
      return FirebaseAuth.instance.currentUser?.photoURL;
    } else if (signProvider == SignProvider.facebook) {
      return FbPhotoTransformer.getPhotoUrl(accessToken, providerId);
    } else if (signProvider == SignProvider.google) {
      return FirebaseAuth.instance.currentUser?.photoURL;
    }
    return null;
  }
}
