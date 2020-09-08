import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'dart:io';
import 'dart:math';

class PhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      //   child: Icon(Icons.add_a_photo),
      // ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('images')
          .orderBy('location')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(),
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children:
            snapshot.map((data) => _buildListItem(context, data)).toList());
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.location),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network(
                  record.url,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  record.caption,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future getImage() async {
  //   // Get image from gallery.
  //   // ignore: deprecated_member_use
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   _uploadImageToFirebase(image);
  // }
  //
  // Future<void> _uploadImageToFirebase(File image) async {
  //   try {
  //     // Make random image name.
  //     int randomNumber = Random().nextInt(100000);
  //     String imageLocation = 'images/image$randomNumber.jpg';
  //
  //     // Upload image to firebase.
  //     final StorageReference storageReference =
  //         FirebaseStorage().ref().child(imageLocation);
  //     final StorageUploadTask uploadTask = storageReference.putFile(image);
  //     await uploadTask.onComplete;
  //     _addPathToDatabase(imageLocation);
  //   } catch (e) {
  //     print(e.message);
  //   }
  // }
  //
  // Future<void> _addPathToDatabase(String text) async {
  //   try {
  //     // Get image URL from firebase
  //     final ref = FirebaseStorage().ref().child(text);
  //     var imageString = await ref.getDownloadURL();
  //
  //     // Add location and url to database
  //     await Firestore.instance
  //         .collection('images')
  //         .document()
  //         .setData({'url': imageString, 'location': text});
  //   } catch (e) {
  //     print(e.message);
  //     showDialog(builder: (context) {
  //       return AlertDialog(
  //         content: Text(e.message),
  //       );
  //     });
  //   }
  // }
}

class Record {
  final String location;
  final String url;
  final String caption;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        location = map['location'],
        url = map['url'],
        caption = map['caption'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url:$caption>";
}
