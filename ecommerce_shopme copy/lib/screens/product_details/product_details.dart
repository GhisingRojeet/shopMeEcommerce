// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:ecommerce_shopme/constants/constants.dart';
import 'package:ecommerce_shopme/constants/routes.dart';
import 'package:ecommerce_shopme/models/product_model/product_model.dart';
import 'package:ecommerce_shopme/provider/app_provider.dart';
import 'package:ecommerce_shopme/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_shopme/screens/check_out/check_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance.push(widget: CartScreen(), context: context);
              },
              icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              Text(widget.singleProduct.description),
              SizedBox(
              height: 12.0,
              ),
               Text("Price: ${widget.singleProduct.price}",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
              SizedBox(
              height: 12.0,
              ),
              Text("Remaining item:  ${widget.singleProduct.qty}", style: TextStyle(color: Colors.red,fontSize: 20.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 12.0,),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        if (qty >1) {
                          qty--;
                        }
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                      onPressed: () {
                        setState(() {
                         
                         if(qty<=widget.singleProduct.qty-1){
                          qty++;

                         }
                            
                        
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: CircleAvatar(
                        child: Icon(Icons.add),
                      ))
                ],
              ),
              // Spacer(),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        appProvider.addCartProduct(productModel);
                        showMessage("Added successfully");
                      },
                      child: Text("ADD TO CART")),
                  SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                      height: 36,
                      width: 140,
                      child: ElevatedButton(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);

                            Routes.instance.push(
                                widget: Checkout(
                                  singleProduct: productModel,
                                ),
                                context: context);
                          },
                          child: Text("Buy")))
                ],
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
