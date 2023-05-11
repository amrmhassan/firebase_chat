// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      imageLink: json['imageLink'] as String?,
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'userModel': instance.userModel,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'imageLink': instance.imageLink,
    };
