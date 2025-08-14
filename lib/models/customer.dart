import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int? customerId;
  final String customerName;
  final String mobile;
  final String email;

  const Customer({
    this.customerId,
    required this.customerName,
    required this.mobile,
    required this.email,
  });

  @override
  List<Object?> get props => [customerId, customerName, mobile, email];
}
