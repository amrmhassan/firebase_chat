import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../transformers/facebook_photo.dart';
import '../../../location/data/models/location_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
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
  @HiveField(6)
  final Gender? gender;
  @HiveField(7)
  final List<String> mobileNumbers;
  @HiveField(8)
  final List<LocationModel> locations;
  @HiveField(9)
  bool emailVerified;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.accessToken,
    required this.provider,
    required this.providerId,
    this.gender,
    this.locations = const [],
    this.mobileNumbers = const [],
    this.emailVerified = false,
  });

  // static UserModel fromJSON(Map<String, dynamic> obj) {
  //   var g = GlobalUtils.stringToEnum(obj[ModelsFields.gender], Gender.values);
  //   return UserModel(
  //     email: obj[ModelsFields.email],
  //     name: obj[ModelsFields.name],
  //     uid: obj[ModelsFields.uid],
  //     accessToken: obj[ModelsFields.accessToken],
  //     provider: obj[ModelsFields.provider],
  //     providerId: obj[ModelsFields.providerId],
  //     gender: g,
  //     mobileNumbers: obj[ModelsFields.mobileNumbers],
  //   );
  // }

  // Map<String, dynamic> toJSON() {
  //   return {
  //     ModelsFields.email: email,
  //     ModelsFields.uid: uid,
  //     ModelsFields.name: name,
  //     ModelsFields.accessToken: accessToken,
  //     ModelsFields.provider: provider,
  //     ModelsFields.providerId: providerId,
  //     ModelsFields.gender: gender?.name,
  //   };
  // }

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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

//? user gender
@HiveType(typeId: 1)
enum Gender {
  @JsonValue('male')
  @HiveField(0)
  male,
  @JsonValue('female')
  @HiveField(1)
  female,
}
