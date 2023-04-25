mixin UserMixin {
  // Future<UserModel> getUserByEmail(String userEmail) async {
  //   var res = await FirebaseFirestore.instance
  //       .collection(DBCollections.users)
  //       .where(ModelsFields.email, isEqualTo: userEmail)
  //       .get();
  //   var userMap = res.docs.first.data();
  //   UserModel userModel = UserModel.fromJSON(userMap);
  //   return userModel;
  // }

  // Future<UserModel> getUserByUID(String uid) async {
  //   var res = await FirebaseFirestore.instance
  //       .collection(DBCollections.users)
  //       .where(ModelsFields.uid, isEqualTo: uid)
  //       .get();
  //   var userMap = res.docs.first.data();
  //   UserModel userModel = UserModel.fromJSON(userMap);
  //   return userModel;
  // }

  // Future<UserModel> saveUserToDB(UserModel userModel) async {
  //   await FirebaseFirestore.instance
  //       .collection(DBCollections.users)
  //       .doc(userModel.uid)
  //       .set(userModel.toJSON());
  //   return userModel;
  // }
}
