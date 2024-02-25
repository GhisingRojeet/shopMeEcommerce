// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes

import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/models/product_model/product_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/product_view/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({
    super.key,
    required this.singleProduct,
    required this.index
  });

  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.3),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.singleProduct.image,
                  height: 80,
                  width: 80,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.singleProduct.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Price: \Rs.${widget.singleProduct.price}"),
                SizedBox(
                  height: 30.0,
                ),
                Text("Qty:${widget.singleProduct.qty}")
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await appProvider
                            .deleteProductsFromFirebase(widget.singleProduct);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: EditProduct(
                              productModel: widget.singleProduct,
                              index: widget.index),
                          context: context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
