import '../auth_repository.dart';
import '../entity.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<User?> call(String email, String password, String name , String phone) async {
    return await authRepository.signUp(email, password,name,phone);
  }
}
