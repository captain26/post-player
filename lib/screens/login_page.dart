import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_player/screens/model/user_info.dart';
import 'package:post_player/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  String firstName;
  String lastName;
  int phoneNumber;
  bool showspinner = false;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> setData(Map<String, dynamic> data, String uid) async {
    final refrence = Firestore.instance.document('users/$uid');
    await refrence.setData(data);
  }

  Future<void> signIn(BuildContext context) async {
    setState(() {
      showspinner = true;
    });
    if (_validateAndSaveForm()) {
      try {
        final auth = Provider.of<AuthBase>(context, listen: false);
        final userInfo = UserInfo(
            firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
        await auth.signInAnonymously();
        String userId = await auth.currentUser();
        await setData(userInfo.toMap(), userId);
      } catch (e) {
        print(e.toString());
      }
    }
    setState(() {
      showspinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Color(0xff072ac8),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8)))),
                  onSaved: (value) => firstName = value,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'First Name is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8)))),
                  autocorrect: false,
                  onSaved: (value) => lastName = value,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Last Name is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff072ac8)))),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => phoneNumber = int.tryParse(value),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Phone Number is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Color(0xff072ac8),
                  onPressed: () => signIn(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
