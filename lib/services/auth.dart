import 'package:firebase_auth/firebase_auth.dart';
import 'package:zzeater/models/user.dart';
import 'package:zzeater/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Returns a formatted user, based on User model, created from a FirebaseUser
  Future<User> _userFromFirebaseUser(FirebaseUser user) async {
    var firstName;
    var lastName;
    var profilePicUrl;

    if (user != null) {
      var userData = await DatabaseService(uid: user.uid).getUserData();

      firstName = userData['firstName'];
      lastName = userData['lastName'];
      profilePicUrl = userData['url'];
    }

    return user != null
        ? User(
            uid: user.uid,
            firstName: firstName,
            lastName: lastName,
            profilePicUrl: profilePicUrl)
        : null;
  }

  // Returns the current FirebaseUser
  Future<FirebaseUser> getCurrentFirebaseUser() async {
    final FirebaseUser user = await _auth.currentUser();

    return user;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .asyncMap((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // Register an user
  Future registerWithEmailAndPassword(
      String firstName, String lastName, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      String defaultProfilePicUrl =
          'https://firebasestorage.googleapis.com/v0/b/zzeater-19a7b.appspot.com/o/default-user.png?alt=media&token=cfcbe4f9-955a-420b-b711-c8e06ceb70f8';

      // Register the new user's data into the users collection
      await DatabaseService(uid: user.uid)
          .updateUserData(firstName, lastName, defaultProfilePicUrl);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
