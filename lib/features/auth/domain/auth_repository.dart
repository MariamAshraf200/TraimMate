import 'entity.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> signUp(String email, String password, String name, String phone);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
