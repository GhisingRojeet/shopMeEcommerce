// ignore_for_file: use_build_context_synchronously, prefer_const_constructors


import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/helpers/firebase_auth_helper/firebase_auth_helper.dart';
// import 'package:admin_panel/screens/auth_ui/sign_up/sign_up.dart';
import 'package:admin_panel/screens/home_page/home_page.dart';
import 'package:admin_panel/widgets/primary_button/primary_button.dart';
import 'package:admin_panel/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(subtitle: "", title: "Login Admin"),
              SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: email,
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
                          isShowPassword?
                          Icons.visibility:Icons.visibility_off,
                          color: Colors.grey,
                        )),),
              ),
              SizedBox(
                height: 36.0,
              ),
              PrimaryButton(
                  onPressed: () async {
                    bool isValidated = loginVaildation(email.text, password.text);
                    if (isValidated) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance
                            .pushAndRemoveUntil(widget: HomePage(), context: context);
                      }
                    }
                  },
                  title: "Login"),
              // SizedBox(
              //   height: 12.0,
              // ),
              // const Center(child: Text("Don't have an account?")),
              // const SizedBox(
              //   height: 12.0,
              // ),
              // Center(
              //     child: CupertinoButton(
              //         onPressed: () {
              //           Routes.instance.push(widget: SignUp(), context: context);
              //         },
              //         child: Text(
              //           "Create an account",
              //           style: TextStyle(color: Theme.of(context).primaryColor),
              //         ))),
            ],
          ),
        ),
      ),
    );
  }
}
