part of '../../../views/screens/authentication/authentication_wrapper_screen.dart';

/// Handles authentication screens repository
class _AuthenticationScreenUseCase extends BaseUseCase {
  final _AuthenticationScreenRepository _repository =
      _AuthenticationScreenRepository();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    UserModel? result = await _repository.login(
      email: email,
      password: password,
    );

    if (result == null) return false;

    AuthController.find.user.value = result;
    return true;
  }

  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    UserModel? result = await _repository.signup(
      email: email,
      password: password,
    );

    if (result == null) return false;

    AuthController.find.user.value = result;
    return true;
  }

  Future<bool> resetPassword({
    required String email,
  }) async {
    return true;
  }
}
