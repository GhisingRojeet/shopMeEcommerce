// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously, prefer_typing_uninitialized_variables, unnecessary_string_escapes

import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/product_model/product_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProduct({Key? key, required this.productModel, required this.index})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qty = TextEditingController();
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
          "Product Edit",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            image == null
                ? widget.productModel.image.isNotEmpty
                    ? CupertinoButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              NetworkImage(widget.productModel.image),
                        ),
                      )
                    : CupertinoButton(
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
              decoration: InputDecoration(hintText: widget.productModel.name),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: description,
              maxLines: 9,
              decoration:
                  InputDecoration(hintText: widget.productModel.description),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "\Rs. ${widget.productModel.price.toString()}"),
            ),
            SizedBox(
              height: 24.0,
            ),
             TextFormField(
              controller: qty,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Quantity:${widget.productModel.qty}"),
            ),
            SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
              child: Text("update"),
              onPressed: () async {
                if (image == null &&
                    name.text.isEmpty &&
                    description.text.isEmpty &&
                    price.text.isEmpty&&
                    qty.text.isEmpty) {
                      showMessage("updated Successfully");
                  Navigator.of(context).pop();
                } else if (image != null) {
                  String imageUrl = await FirebaseStorageHelper.instance
                      .uploadUserImage(widget.productModel.id, image!);
                  ProductModel productModel = widget.productModel.copyWith(
                    description:
                        description.text.isEmpty ? null : description.text,
                    image: imageUrl,
                    name: name.text.isEmpty ? null : name.text,
                    price: price.text.isEmpty ? null : price.text,
                    qty: qty.text.isEmpty ? null : qty.text,
                  );
      
                  appProvider.updateProductList(widget.index, productModel);
                  showMessage("Updated Successfully");
                } else {
                  ProductModel productModel = widget.productModel.copyWith(
                    description:
                        description.text.isEmpty ? null : description.text,
                    name: name.text.isEmpty ? null : name.text,
                    price: price.text.isEmpty ? null : price.text,
                    qty: qty.text.isEmpty ? null : qty.text,
                  );
      
                  appProvider.updateProductList(widget.index, productModel);
                  showMessage("Updated Successfully");
      
                }
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
