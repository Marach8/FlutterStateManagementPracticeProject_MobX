abstract class AuthService{
  String? get userId; Future<bool> deleteAcccountAndSignOut();
  Future<void> signOut(); 
  Future<bool> register({required String email, required String password});
  Future<bool> login({required String email, required String password});
  }