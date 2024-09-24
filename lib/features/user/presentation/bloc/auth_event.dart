import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignupEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});
  @override
  List<Object?> get props => [email, password, name, phone];
}

class LogoutEvent extends AuthEvent {
  LogoutEvent();
  @override
  List<Object?> get props => [];
}

class ResetpasswordEvent extends AuthEvent {
  final String email;

  ResetpasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
