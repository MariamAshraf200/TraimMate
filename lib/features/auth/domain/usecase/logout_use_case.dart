import '../auth_repository.dart';

class LogoutUseCase{
  final AuthRepository authRepository;

  LogoutUseCase( this.authRepository);

  Future<void>call() async {
    return await authRepository.logout();
  }
}