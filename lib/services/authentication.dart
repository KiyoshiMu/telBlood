import 'package:firebase_auth/firebase_auth.dart';
import 'package:telblood/services/authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  getFirebaseAuth() {
    return _firebaseAuth;
  }
  @override
  Future<String> currentUser() async {
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return user.uid;
  }
  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
  @override
  Future<String> signInWithEmails({String email, String pwd}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, password: pwd);
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return user.uid;
  }
  @override
  Future<String> createUser({String email, String pwd}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: pwd);
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return user.uid;
  }
  @override
  Future<bool> isVerified() async {
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
  @override
  Future<void> sendVerification() async {
    FirebaseUser user =  await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }
}



