// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:ecommerce_shopme/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';





class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=  Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty?Center(child: Text("Shop more with shopMe",style: TextStyle(fontWeight: FontWeight.bold),),)
          :ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: appProvider.getFavouriteProductList.length,
          itemBuilder: (ctx, index) {
            return SingleFavouriteItem(singleProduct: appProvider.getFavouriteProductList[index],);
          }),
    );
  }
}
