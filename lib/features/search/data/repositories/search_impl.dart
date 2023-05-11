import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/search/data/datasourses/search_datasource.dart';
import 'package:firebase_chat/features/search/data/models/search_result_model.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/search/domain/repositories/search_repo.dart';

import '../../../../core/errors/firebase_errors.dart';

class SearchImpl implements SearchRepo {
  final SearchDatasource _searchDatasource;
  const SearchImpl(this._searchDatasource);

  @override
  Future<Either<Failure, List<SearchResultModel>>> search(String query) async {
    try {
      var res = await _searchDatasource.search(query);
      return res;
    } on FirebaseException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }
}
