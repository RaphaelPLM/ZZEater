import 'package:firebase_auth/firebase_auth.dart';
import 'package:zzeater/models/user.dart';
import 'package:zzeater/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Returns an formatted user, based on User model, created from a FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user,
      [String email, String firstName, String lastName]) {
    return user != null
        ? User(
            uid: user.uid,
            firstName: firstName,
            lastName: lastName,
            email: email)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Returns the current FirebaseUser
  Future<FirebaseUser> getCurrentFirebaseUser() async {
    final FirebaseUser user = await _auth.currentUser();

    return user;
  }

  // Register an user
  Future registerWithEmailAndPassword(
      String firstName, String lastName, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      // Register the new user's data into the users collection
      await DatabaseService(uid: user.uid).updateUserData(firstName, lastName);

      return _userFromFirebaseUser(user, email, firstName, lastName);
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

      return _userFromFirebaseUser(user, email);
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
