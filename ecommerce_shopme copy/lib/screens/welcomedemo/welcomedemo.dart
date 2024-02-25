// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_shopme/constants/asset_images.dart';
import 'package:ecommerce_shopme/constants/routes.dart';
import 'package:ecommerce_shopme/screens/auth_ui/login/login.dart';
import 'package:ecommerce_shopme/screens/auth_ui/sign_up/sign_up.dart';
import 'package:ecommerce_shopme/widgets/primary_button/primary_button.dart';
import 'package:ecommerce_shopme/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(title: "welcome", subtitle: "Make your daily life easier with shopme"),
            const SizedBox(
              height: kToolbarHeight + 12,
            ),

            Center(child: Image.asset(AssetsImages.instance.welcomeImage)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CupertinoButton(
            //       onPressed: () {},
            //       padding: EdgeInsets.zero,
            //       child: const Icon(
            //         Icons.facebook,
            //         color: Colors.blue,
            //         size: 35,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 12.0,
            //     ),
            //     CupertinoButton(
            //       onPressed: () {},
            //       padding: EdgeInsets.zero,
            //       child: Image.asset(
            //         AssetsImages.instance.googleLogo,
            //         scale: 6.0,
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 30.0,
            ),
            PrimaryButton(onPressed: () {
              Routes.instance.push(widget:Login(), context: context);
            }, title: "Login"),
            const SizedBox(
              height: 18.0,
            ),
            PrimaryButton(onPressed: () {
              Routes.instance.push(widget: SignUp(), context: context);
            }, title: "Sign Up"),
          ],
        ),
      ),
    );
  }
}
