abstract class AuthenticationApi {
  getFirebaseAuth();
  Future<String> currentUser();
  Future<void> signOut();
  Future<String> signInWithEmails({String email, String pwd});
  Future<String> createUser({String email, String pwd});
  Future<void> sendVerification();
  Future<bool> isVerified();
}