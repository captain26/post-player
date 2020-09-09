import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_player/screens/drawer_screen.dart';
import 'dart:io';
import 'dart:math';

class AddBannerPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: FlatButton(
            onPressed: _openDrawer,
            child: Icon(
              Icons.menu,
              color: Color(0xff072ac8),
            ),
          ),
          title: Center(
              child: Text(
                'Post Player',
                style: TextStyle(color: Color(0xff072ac8)),
              )),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: getImage,
            child: Text('Upload Banner Photo'),
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
    String imageLocation = 'bannerphotos/image$randomNumber.jpg';

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
    await Firestore.instance.collection('bannerphoto').document().setData({
      'url': imageString,
      'location': text,
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
