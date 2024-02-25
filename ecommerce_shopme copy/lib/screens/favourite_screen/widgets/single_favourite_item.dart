// ignore_for_file: sort_child_properties_last, prefer_const_constructors, depend_on_referenced_packages, unnecessary_string_escapes

import 'package:ecommerce_shopme/models/product_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.6),
              child:Image.network(widget.singleProduct.image)
              ,

            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),
                            ),

                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                AppProvider appProvider=  Provider.of<AppProvider>(context,listen: false);
                                appProvider.removeFavouriteProduct(widget.singleProduct);
                                showMessage("Removed from wishlist");
                              },
                              child: Text("Remove from wishlist",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),
                              ),
                            ),





                          ],
                        ),
                        Text("\Rs.${widget.singleProduct.price.toString()}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),
                        ),
                      ],
                    ),
                    ],
                ),
              ),

            ),
          )
        ],
      ),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).primaryColor, width: 3)),
    );
  }
}



