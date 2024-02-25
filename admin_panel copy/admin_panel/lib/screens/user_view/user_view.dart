// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/models/user_model/user_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/user_view/widgets/single_view_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User view"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
              padding: EdgeInsets.all(12.0),
              itemCount: value.getUserList.length,
              itemBuilder: (context, index) {
                UserModel userModel = value.getUserList[index];
                return SingleUserCard(userModel: userModel,index: index,);
              });
        },
      ),
    );
  }
}
