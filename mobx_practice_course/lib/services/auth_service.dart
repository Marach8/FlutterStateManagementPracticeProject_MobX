import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx_practice_course/auth/auth_errors.dart';
import 'package:mobx_practice_course/providers/auth_provider.dart';


//This entire file is to make the Application testatble


  class FirebaseAuthService implements AuthService{
  @override
  Future<bool> deleteAcccountAndSignOut() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){return false;}
    try{
      await user.delete(); 
      await FirebaseAuth.instance.signOut(); 
      return true;
    } on FirebaseAuthException catch (e){
      final error = AuthError.from(e); 
      throw error;
    } catch (e){rethrow;}
  }
  
  @override
  Future<bool> login({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }
  
  @override
  Future<bool> register({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }
  
  @override
  Future<void> signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
    } catch (_){}
  }
  
  @override
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  }