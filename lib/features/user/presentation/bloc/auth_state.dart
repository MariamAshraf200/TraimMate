import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initstate extends AuthState {}

class Loadingstate extends AuthState {}

class SucessLoginstate extends AuthState {}

class FailureLoginstate extends AuthState {
  final String message;

  FailureLoginstate({required this.message});
  @override
  List<Object?> get props => [message];
}

class SuccesSignupstate extends AuthState {}

class FailureSignUpstate extends AuthState {
  final String message;

  FailureSignUpstate({required this.message});
  @override
  List<Object?> get props => [message];
}

class SuccessResetpasswordState extends AuthState {}

class FailureResetpasswordstate extends AuthState {
  final String message;

  FailureResetpasswordstate({required this.message});
  @override
  List<Object?> get props => [message];
}

class SuccesLogoutstate extends AuthState {}

class FailureLogoutstate extends AuthState {
  final String message;

  FailureLogoutstate({required this.message});
  @override
  List<Object?> get props => [message];
}
