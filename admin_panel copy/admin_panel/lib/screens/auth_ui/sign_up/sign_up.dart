// ignore_for_file: use_build_context_synchronously, prefer_const_constructors


import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:admin_panel/screens/home_page/home_page.dart';
import 'package:admin_panel/widgets/primary_button/primary_button.dart';
import 'package:admin_panel/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopTitles(
                    subtitle: "Welcome to ShopMe", title: "Create account"),
                SizedBox(
                  height: 46.0,
                ),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "UserName",
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  controller: password,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                      hintText: "Password",
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
                  height: 36.0,
                ),
                PrimaryButton(
                    onPressed: () async {
                      bool isValidated = signUpValidation(
                          email.text, password.text, name.text, phone.text);
                      if (isValidated) {
                        bool isLogined = await FirebaseAuthHelper.instance
                            .signUp(name.text,email.text, password.text, context);
                        if (isLogined) {
                          Routes.instance.pushAndRemoveUntil(
                              widget: const HomePage(), context: context);
                        }
                      }
                    },
                    title: "Create an account"),
                SizedBox(
                  height: 12.0,
                ),
                const Center(child: Text("Already have an account?")),
                const SizedBox(
                  height: 12.0,
                ),
                Center(
                    child: CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Login",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
