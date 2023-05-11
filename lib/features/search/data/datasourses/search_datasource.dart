import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/search_result_model.dart';

abstract class SearchDatasource {
  Future<Either<Failure, List<SearchResultModel>>> search(String query);
}
