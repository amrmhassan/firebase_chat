import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class LocationModel {
  @HiveField(0)
  final String location;
  @HiveField(1)
  final String latLng;

  const LocationModel({
    required this.location,
    required this.latLng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
