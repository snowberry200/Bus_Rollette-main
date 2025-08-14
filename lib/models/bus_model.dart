import 'package:equatable/equatable.dart';

class Bus extends Equatable {
  final int? busId;
  final String busName;
  final String busNumber;
  final String busType;
  final int totalSeat;

  const Bus({
    this.busId,
    required this.busName,
    required this.busNumber,
    required this.busType,
    required this.totalSeat,
  });

  @override
  List<Object?> get props => [busId, busName, busNumber, busType, totalSeat];
}
