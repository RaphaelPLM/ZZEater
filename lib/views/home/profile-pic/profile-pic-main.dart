import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zzeater/services/uploader.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selectedImage = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: () => _pickImage(ImageSource.camera),
        ),
        IconButton(
          icon: Icon(Icons.photo_library),
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
        Uploader(file: _imageFile)
      ]),
    );
  }
}
