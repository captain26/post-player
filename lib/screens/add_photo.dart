import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_player/screens/drawer_screen.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String _caption;
String _title;

class AddPhotoPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Photo Page",
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF394989),
      ),
      drawer: DrawerScreen(),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  contentPadding:
                      EdgeInsets.only(top: 25, bottom: 25, left: 20),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 0, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Title is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _title = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Caption',
                  contentPadding:
                      EdgeInsets.only(top: 25, bottom: 25, left: 20),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 0, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Caption is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _caption = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  getImage();
                },
                child: Text(
                  'Upload Photo',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future getImage() async {
  // Get image from gallery.
  // ignore: deprecated_member_use
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  _uploadImageToFirebase(image);
}

Future<void> _uploadImageToFirebase(File image) async {
  try {
    // Make random image name.
    int randomNumber = Random().nextInt(10000000);
    String imageLocation = 'images/image$randomNumber.jpg';
    // Upload image to firebase.
    final StorageReference storageReference =
        FirebaseStorage().ref().child(imageLocation);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    _addPathToDatabase(imageLocation);
  } catch (e) {
    print(e.message);
  }
}

Future<void> _addPathToDatabase(String text) async {
  try {
    // Get image URL from firebase
    final ref = FirebaseStorage().ref().child(text);
    var imageString = await ref.getDownloadURL();
    await Firestore.instance.collection('images').document().setData({
      'url': imageString,
      'location': text,
      'caption': _caption,
      'title': _title,
      'createdOn': FieldValue.serverTimestamp()
    });
  } catch (e) {
    print(e.message);
    showDialog(
        builder: (context) {
          return AlertDialog(
            content: Text(e.message),
          );
        },
        context: null);
  }
}
