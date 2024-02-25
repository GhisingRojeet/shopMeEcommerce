// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously, curly_braces_in_flow_control_structures, unnecessary_string_escapes

import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget { 
  
  const AddProduct({Key? key,})
      : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qty = TextEditingController();
  CategoryModel? _selectedCategory;
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
          "Add Product",
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
                      child: CircleAvatar(
                        radius: 55,
                        child: Icon(Icons.camera_alt),
                      ),
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
            decoration: InputDecoration(hintText: "Product Name"),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: description,
            maxLines: 9,
            decoration:
                InputDecoration(hintText: "Description"),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "\Rs.Product Price"),
          ),
          SizedBox(height: 24.0,),
          Theme(
            data: Theme.of(context).copyWith(canvasColor:Colors.white),
            child: DropdownButtonFormField(
                  value: _selectedCategory,
                  hint: Text(
                'Select Category',
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                  setState(() {
                      _selectedCategory = value;
                  });
                },
                
                
                  items: appProvider.getCategories
            .map((CategoryModel val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                          val.name,
                          ),
                        );
                      }).toList(),
                  ),
          ),
          SizedBox(
            height: 24.0,
          ),
        TextFormField(
          controller: qty,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Quantity"
          ),

        ),
                  SizedBox(height: 24.0,),

          ElevatedButton(
            child: Text("Add"),
            onPressed: () async {
              if (image == null ||
              _selectedCategory  == null ||
                  name.text.isEmpty ||
                  description.text.isEmpty ||
                  price.text.isEmpty || qty.text.isEmpty) {
                    showMessage(" Please Fill all Information");
                // Navigator.of(context).pop();
              } else{
                
               

                appProvider.addProduct(image!, name.text, _selectedCategory!.id, price.text, description.text, qty.text);
                showMessage("Product Added Successfully");
              }
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
