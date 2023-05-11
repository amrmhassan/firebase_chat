import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  final UserModel userModel;
  final String title;
  final String subTitle;
  final String? imageLink;

  const SearchResultModel({
    required this.userModel,
    required this.title,
    required this.subTitle,
    required this.imageLink,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}
