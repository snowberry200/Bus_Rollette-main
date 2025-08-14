import 'package:equatable/equatable.dart';

import '../utils/constants.dart';

class ResponseModel extends Equatable {
  final ResponseStatus responseStatus;
  final int statusCode;
  final String message;
  final Map<String, dynamic> object;

  const ResponseModel({
    required this.responseStatus,
    required this.statusCode,
    required this.message,
    required this.object,
  });

  @override
  List<Object?> get props => [responseStatus, statusCode, message, object];
}
