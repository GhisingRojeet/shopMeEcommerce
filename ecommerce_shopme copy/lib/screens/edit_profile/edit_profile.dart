 // ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:io';

import 'package:ecommerce_shopme/provider/app_provider.dart';
import 'package:ecommerce_shopme/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/user_model/user_model.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
File? image;
  void takePicture()async{
    XFile? value= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40);
    if(value!=null){
       setState(() {
         image=File(value.path);
       });
    }
  }
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=  Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile",style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image==null? CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: CircleAvatar(
              radius: 55,
              child: Icon(Icons.camera_alt)
            ),
          )
          :CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage: FileImage(image!),
            ),
          ),
          SizedBox(height: 12.0,),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: appProvider.getUserInformation.name,
            ),
          ),
          SizedBox(height: 24.0,),
          PrimaryButton(title: "update",onPressed: () async{
            UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
            appProvider.updateUserInfoFirebase(context, userModel, image);
          },)

        ],
      ),
    );
  }
}

