import 'package:equatable/equatable.dart';

import 'bus_model.dart';
import 'bus_route.dart';

class BusSchedule extends Equatable {
  final int? scheduleId;
  final Bus bus;
  final BusRoute busRoute;
  final String departureTime;
  final int ticketPrice;
  final int discount;
  final int processingFee;

  const BusSchedule({
    this.scheduleId,
    required this.bus,
    required this.busRoute,
    required this.departureTime,
    required this.ticketPrice,
    this.discount = 0,
    this.processingFee = 50,
  });

  @override
  List<Object?> get props => [
    scheduleId,
    bus,
    busRoute,
    departureTime,
    ticketPrice,
    discount,
    processingFee,
  ];
}
