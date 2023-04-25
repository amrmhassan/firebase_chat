import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/transformers/collections.dart';
import 'package:firebase_chat/transformers/models_fields.dart';

mixin UserMixin {
  Future<UserModel> getUserByEmail(String userEmail) async {
    var res = await FirebaseFirestore.instance
        .collection(DBCollections.users)
        .where(ModelsFields.email, isEqualTo: userEmail)
        .get();
    var userMap = res.docs.first.data();
    UserModel userModel = UserModel.fromJSON(userMap);
    return userModel;
  }

  Future<UserModel> saveUserToDB(UserEntity userEntity) async {
    await FirebaseFirestore.instance
        .collection(DBCollections.users)
        .doc(userEntity.uid)
        .set(userEntity.toJSON());
    return userEntity;
  }
}
