import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final int? id;
  final String userName;
  final String password;
  final String role;

  const AppUser({
    this.id,
    required this.userName,
    required this.password,
    this.role = 'Admin',
  });

  @override
  List<Object?> get props => [id, userName, password, role];
}
