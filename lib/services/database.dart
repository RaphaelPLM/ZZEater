import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName) async {
    return await usersCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName
    });
  }

  // Get users stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
