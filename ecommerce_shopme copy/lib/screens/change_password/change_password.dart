// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_shopme/constants/constants.dart';
import 'package:ecommerce_shopme/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "New Password",
                prefixIcon: Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ))),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.password_sharp),
                 ),
          ),
          SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "update",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("new password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Confirm  password is empty");
              } else {
                if (confirmpassword.text == newpassword.text) {
                  FirebaseAuthHelper.instance
                      .ChangePassword(newpassword.text, context);
                } else {
                  showMessage("Confirm password doesnot match");
                }
              }
            },
          )
        ],
      ),
    );
  }
}
