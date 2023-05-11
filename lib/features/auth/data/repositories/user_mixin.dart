import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/transformers/collections.dart';

mixin UserMixin {
  Future<void> saveUserToDb(UserModel userModel) async {
    // checking if the user is already saved to database
    UserModel? savedModel;
    var userJson = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .doc(userModel.uid)
            .get())
        .data();
    if (userJson != null) {
      savedModel = UserModel.fromJson(userJson);
    }
    // if the user isn't saved to db then save it's info
    if (savedModel == null) {
      await FirebaseFirestore.instance
          .collection(DBCollections.users)
          .doc(userModel.uid)
          .set(userModel.toJson());
    }
  }
}
