import 'package:bloc/bloc.dart';
import '../../domain/usecase/login_use_case.dart';
import '../../domain/usecase/logout_use_case.dart';
import '../../domain/usecase/sign_up_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc( {
  required  this.logoutUseCase,
    required this.loginUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final user = await loginUseCase(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(message: "Login Failed"));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final user = await signUpUseCase(event.email, event.password,event.phone,event.name);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(message: "Sign Up Failed"));
      }
    });

on<LogoutEvent>((event,emit) async{
  emit(AuthLoading());
  await logoutUseCase;
  emit(AuthLoggedOut());
});
  }
}
