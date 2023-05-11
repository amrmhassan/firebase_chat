import 'package:dartz/dartz.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/search/data/models/search_result_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<SearchResultModel>>> search(String query);
}
