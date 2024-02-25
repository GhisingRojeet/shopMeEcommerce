// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, avoid_unnecessary_containers

import 'package:ecommerce_shopme/constants/routes.dart';
import 'package:ecommerce_shopme/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_shopme/screens/about_us/about_us.dart';
import 'package:ecommerce_shopme/screens/change_password/change_password.dart';
import 'package:ecommerce_shopme/screens/edit_profile/edit_profile.dart';
import 'package:ecommerce_shopme/screens/favourite_screen/widgets/favourite_screen.dart';
import 'package:ecommerce_shopme/screens/order_screen/order_screen.dart';
import 'package:ecommerce_shopme/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Account",
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              appProvider.getUserInformation.image ==null
                  ? const Icon(
                      Icons.person_outline,
                      size: 100,
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(appProvider.getUserInformation.image!),
                    ),
              Text(
                appProvider.getUserInformation.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              Text(
                appProvider.getUserInformation.email,
              ),
              SizedBox(
                height: 12.0,
              ),
              SizedBox(
                  width: 125,
                  child: PrimaryButton(
                onPressed: () {
                        Routes.instance
                            .push(widget: EditProfile(), context: context);
                      },
                      
                      title: "Edit Profile"))
            ],
          )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: OrderScreen(), context: context);
                    },
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text("Your order"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: FavouriteScreen(), context: context);
                    },
                    leading: Icon(Icons.favorite_border_outlined),
                    title: Text("Favourite"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const AboutUs(), context: context);                      },
                    leading: Icon(Icons.question_mark_outlined),
                    title: Text("About us"),
                  ),

                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: ChangePassword(), context: context);
                    },
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text("Change password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: Icon(Icons.exit_to_app_rounded),
                    title: Text("Logout"),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    "version 1.0.0 of shopme by Rojeet Ghising",
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
