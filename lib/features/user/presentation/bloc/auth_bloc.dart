import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/core/strings/messages.dart';
import 'package:check_weather/features/user/domain/entities/user_entity.dart';
import 'package:check_weather/features/user/domain/usecases/user_login.dart';
import 'package:check_weather/features/user/domain/usecases/user_logout.dart';
import 'package:check_weather/features/user/domain/usecases/user_resstpassword.dart';
import 'package:check_weather/features/user/domain/usecases/user_signup.dart';
import 'package:check_weather/features/user/presentation/bloc/auth_event.dart';
import 'package:check_weather/features/user/presentation/bloc/auth_state.dart';
import 'package:dartz/dartz.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLoginUsecase loginUsecase;
  final UserSignupUsecase signupUsecase;
  final UserLogoutUsecase logoutUsecase;
  final UserResstpasswordUsecas resetPasswordUsecase; // Fixed name

  AuthBloc({
    required this.loginUsecase,
    required this.signupUsecase,
    required this.logoutUsecase,
    required this.resetPasswordUsecase, // Fixed name
  }) : super(Initstate()) {
    on<LoginEvent>(_loginEvent);
    on<LogoutEvent>(_logoutEvent);
    on<SignupEvent>(_signupEvent);
    on<ResetpasswordEvent>(_resetPasswordEvent); // Fixed name
  }

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(Loadingstate());
    final Either<Failures, UserEntity> result =
    await loginUsecase(event.email, event.password);
    result.fold(
          (failure) => emit(FailureLoginstate(message: _failureMessage(failure))),
          (user) => emit(SucessLoginstate()),
    );
  }

  Future<void> _signupEvent(SignupEvent event, Emitter<AuthState> emit) async {
    emit(Loadingstate());
    final Either<Failures, UserEntity> result = await signupUsecase(
      event.email,
      event.password,
      event.name,
      event.phone,
    );
    result.fold(
          (failure) => emit(FailureSignUpstate(message: _failureMessage(failure))),
          (user) => emit(SuccesSignupstate()),
    );
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(Loadingstate());
    final Either<Failures, Unit> result = await logoutUsecase();
    result.fold(
          (failure) => emit(FailureLogoutstate(message: _failureMessage(failure))),
          (_) => emit(SuccesLogoutstate()),
    );
  }

  Future<void> _resetPasswordEvent(ResetpasswordEvent event, Emitter<AuthState> emit) async {
    emit(Loadingstate());
    final Either<Failures, Unit> result = await resetPasswordUsecase(event.email);
    result.fold(
          (failure) => emit(FailureResetpasswordstate(message: _failureMessage(failure))),
          (_) => emit(SuccessResetpasswordState()),
    );
  }

  String _failureMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailuer:
        return ServerFailureMessage;
      case OfflineFailuer:
        return OfflineFailureMessfage;
      case WrongDataFailuer:
        return WrongDataFailureMessage;
      default:
        return UnExpectedFailureMessage;
    }
  }
}
