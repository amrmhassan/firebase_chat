import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'location_model.g.dart';

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
}
