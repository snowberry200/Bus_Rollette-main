import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final int statusCode;
  final String message;
  final String accessToken;
  final int logInTime;
  final int expirationDuration;

  const AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.logInTime,
    required this.expirationDuration,
  });

  @override
  List<Object?> get props => [
    statusCode,
    message,
    accessToken,
    logInTime,
    expirationDuration,
  ];
}
