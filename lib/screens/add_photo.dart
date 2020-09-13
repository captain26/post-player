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
        backgroundColor: Color(0xff072ac8),
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xff072ac8))),
                  ),
                  cursorColor: Color(0xff072ac8),

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
                    hintText: 'Captain',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xff072ac8))),
                  ),
                  cursorColor: Color(0xff072ac8),

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
                FlatButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    getImage();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Color(0xff072ac8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Upload Photo',
                      style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.22,
                      child: Text(
                        'Designed By : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.1,
                      child: ImageIcon(
                        AssetImage('assets/images/dev.png'),
                        size: 70.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
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
