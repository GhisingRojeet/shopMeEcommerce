// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_shopme/constants/constants.dart';
import 'package:ecommerce_shopme/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_shopme/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ecommerce_shopme/models/order_model/order_model.dart';
import 'package:ecommerce_shopme/models/product_model/product_model.dart';
import 'package:ecommerce_shopme/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  //Cart List

  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //Favourite==========

  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }
  // void newQty(ProductModel productModel){
  //   int Total = _buyProductList[Index].qty;
  // }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  ///user Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.UploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Succesfully updated profile");

    notifyListeners();
  }

  /// Total price /////
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty;
    }
    return totalPrice;
  }
  //  void productQuantity(String productId, OrderModel orderModel,double qty){
  //    final productIndex = _products.indexWhere((product) => product.id == productId);
  //     final product = _products[productIndex];
  //     final newQty = product.qty - orderModel.products[0].qty;
  //     _products[productIndex] = ProductModel(
  //       id: product.id,
  //       name: product.name,
  //       price: product.price,
  //       image: product.image,
  //       description: product.description,
  //       isFavourite: false,
  //       qty: newQty,

  //     );
  //     notifyListeners();

  // }
  void newQty(ProductModel productModel, OrderModel orderModel, double qty,
      String productId) {
    final productIndex =
        _cartProductList.indexWhere((product) => product.id == productId);
    final product = _cartProductList[productIndex];
    final quantity = product.qty - orderModel.products[0].qty;
    _cartProductList[productIndex] = ProductModel(
        image: product.image,
        id: product.id,
        name: product.name,
        price: product.price,
        description: product.description,
        isFavourite: false,
        qty: quantity);
        notifyListeners();
  }

  void updateQty(ProductModel productModel, double qty) {
    int index = _cartProductList.indexOf(productModel);
    qty = _cartProductList[index].qty;

    notifyListeners();
  }

  /// BUY PRODUCTS////////////////

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
