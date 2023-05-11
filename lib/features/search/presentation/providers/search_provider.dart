import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/search/data/datasourses/remote_search.dart';
import 'package:firebase_chat/features/search/data/models/search_result_model.dart';
import 'package:firebase_chat/features/search/data/repositories/search_impl.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchResultModel> results = [];
  bool searching = false;
  Future<Either<Failure, Unit>> search(String query) async {
    searching = true;
    results.clear();
    notifyListeners();
    var res = await SearchImpl(RemoteSearch()).search(query);
    searching = false;
    notifyListeners();

    var data = res.fold((l) => l, (r) => r);
    if (data is Failure) {
      return Left(data);
    } else {
      results = [...(data as List<SearchResultModel>)];
      notifyListeners();
      return const Right(unit);
    }
  }
}
