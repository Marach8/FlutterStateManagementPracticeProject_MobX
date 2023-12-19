import 'package:mobx_practice_course/extension/extensions.dart';
import 'package:mobx_practice_course/providers/auth_provider.dart';

class MockAuthService implements AuthService{
  @override
  Future<bool> deleteAcccountAndSignOut() => true.toFuture(oneSecond);

  @override
  Future<bool> login({required String email, required String password}) => true.toFuture(oneSecond);

  @override
  Future<bool> register({required String email, required String password}) => true.toFuture(oneSecond);

  @override
  Future<void> signOut() => Future.delayed(oneSecond);
    
  @override
  String? get userId => 'marach';
}