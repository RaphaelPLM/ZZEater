import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zzeater/services/auth.dart';
import 'package:zzeater/services/database.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://zzeater-19a7b.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() async {

    // Determine the file path in Fire Storage
    String filePath = 'images/${DateTime.now()}.png';
    
    // Uploads the file to the specified path
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });

    // Await for the uploaded image URL;
    var url = await getDownloadUrl();

    // If the operation was succesful, stores the url into the current user register, in Firebase
    if(url != null)
    {
      final AuthService _auth = AuthService();
      var currentUser = await _auth.getCurrentFirebaseUser();

      // Update current user registry, adding the URL of the new profile pic
      DatabaseService(uid: currentUser.uid).updateUserProfilePic(url);
    }

  }

  Future<String> getDownloadUrl() async {
    var url = await ( await _uploadTask.onComplete).ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
      return FlatButton.icon(
        label: Text('Upload'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
  }
}
