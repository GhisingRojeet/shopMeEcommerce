// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/user_model/user_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  final UserModel userModel;
  final index;
  const EditUser({Key? key, required this.userModel,required this.index}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController name = TextEditingController();
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "User Edit",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child:
                      CircleAvatar(radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(hintText: widget.userModel.name),
          ),
          SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            child: Text("update"),
            onPressed: () async {
              if(image == null && name.text.isEmpty){
                Navigator.of(context).pop();
              }
              else if(image!=null){
              String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.userModel.id,image!);
              UserModel userModel = widget.userModel.copyWith(
                image: imageUrl,
                name: name.text.isEmpty?null:name.text,
              );
              appProvider.updateUserList(widget.index, userModel);
              showMessage("Updated Successfully");
              }else{
              UserModel userModel = widget.userModel.copyWith(
                name: name.text.isEmpty?null:name.text,
              );
              appProvider.updateUserList(widget.index,userModel);
              showMessage("Updated Successfully");
              }
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
