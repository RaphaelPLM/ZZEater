import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference

  final String uid;
  
  // Constructor
  DatabaseService({this.uid});

  //-------------METHODS

  // Reference to the users collection
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // Set user personal data (first and last names)
  Future updateUserData(String firstName, String lastName) async {
    return await usersCollection
        .document(uid)
        .setData({'firstName': firstName, 'lastName': lastName});
  }

  // Adds a profile pic to an existing user
  Future updateUserProfilePic(String url) async  {
    return await usersCollection.document(uid).updateData({'url': url});
  }

  // Get users stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
