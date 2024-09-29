import '../auth_repository.dart';
import '../entity.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<User?> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
