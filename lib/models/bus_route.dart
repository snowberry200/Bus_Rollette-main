import 'package:equatable/equatable.dart';

class BusRoute extends Equatable {
  final int? routeId;
  final String routeName;
  final String cityFrom;
  final String cityTo;
  final double? distanceInKm;

  const BusRoute({
    this.routeId,
    required this.routeName,
    required this.cityFrom,
    required this.cityTo,
    required this.distanceInKm,
  });

  @override
  List<Object?> get props => [
    routeId,
    routeName,
    cityFrom,
    cityTo,
    distanceInKm,
  ];
}
