import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/search/data/datasourses/search_datasource.dart';
import 'package:firebase_chat/features/search/data/models/search_result_model.dart';
import 'package:firebase_chat/transformers/collections.dart';
import 'package:firebase_chat/transformers/models_fields.dart';

class RemoteSearch implements SearchDatasource {
  @override
  Future<Either<Failure, List<SearchResultModel>>> search(String query) async {
    //? right now this search functionality works for searching with users emails only
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .where(ModelsFields.email, isEqualTo: query)
            .get())
        .docs;
    var users = docs.map((e) => UserModel.fromJson(e.data())).toList();
    var res = await Future.wait(users.map(
      (e) async => SearchResultModel(
        userModel: e,
        title: e.name,
        subTitle: e.email,
        imageLink: await e.photoUrl,
      ),
    ));
    return Right(res);
  }
}
