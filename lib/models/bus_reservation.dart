import 'package:equatable/equatable.dart';

import 'bus_schedule.dart';
import 'customer.dart';

class BusReservation extends Equatable {
  final int? reservationId;
  final Customer customer;
  final BusSchedule busSchedule;
  final int timestamp;
  final String departureDate;
  final int totalSeatBooked;
  final String seatNumbers;
  final String reservationStatus;
  final int totalPrice;

  const BusReservation({
    this.reservationId,
    required this.customer,
    required this.busSchedule,
    required this.timestamp,
    required this.departureDate,
    required this.totalSeatBooked,
    required this.seatNumbers,
    required this.reservationStatus,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
    reservationId,
    customer,
    busSchedule,
    timestamp,
    departureDate,
    totalSeatBooked,
    seatNumbers,
    reservationStatus,
    totalPrice,
  ];
}
