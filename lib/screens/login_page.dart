import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:post_player/common/platform_exception_alert_dialog.dart';
import 'package:post_player/screens/model/user_info.dart';
import 'package:post_player/services/auth.dart';
import 'package:provider/provider.dart';

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
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Sign in failed',
          exception: e,
        ).show(context);
      }finally{
        setState(() {
          showspinner = false;
        });
      }
    }
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
                CustomTextField(
                  placeholder: 'First Name',
                  errorMessage: 'First Name is Required',
                  type: firstName,
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  placeholder: 'Last Name',
                  errorMessage: 'Last Name is Required',
                  type: lastName,
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  placeholder: 'Phone Number',
                  errorMessage: 'Phone Number is Required',
                  type: phoneNumber,
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () => signIn(context),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color: const Color(0xff072ac8),
                      border: Border.all(width: 1.0, color: const Color(0xff072ac8)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String placeholder;
  dynamic type;
  final String errorMessage;

  CustomTextField({this.placeholder, this.type,this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 42.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xffffffff),
        border: Border.all(width: 0.25, color: const Color(0xff707070)),
      ),
      child: TextFormField(
        onSaved: (value) => type = value,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff072ac8))),
          hintText: placeholder,
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontFamily: 'SourceSansPro',
            fontSize: 16,
            color: const Color(0x80072ac8),
          ),
          contentPadding: const EdgeInsets.only(bottom: 8, left: 8),
          hoverColor: Colors.grey,
        ),
        cursorColor: Colors.grey,
        validator: (String value) {
          if (value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
