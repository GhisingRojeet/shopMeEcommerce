// ignore_for_file: sort_child_properties_last, prefer_const_constructors, depend_on_referenced_packages, unnecessary_string_escapes

import 'package:ecommerce_shopme/models/product_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  double qty = 1.0;
  @override
  void initState() {
    qty = widget.singleProduct.qty;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.6),
              child: Image.network(widget.singleProduct.image),
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
                            FittedBox(
                              child: Text(
                                widget.singleProduct.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty >1) {
                                       qty--;
                                      }
                                    });
                                    appProvider.updateQty(widget.singleProduct, qty);
                                    
                                    

                                  },
                                  padding: EdgeInsets.zero,
                                  child: CircleAvatar(
                                    maxRadius: 12,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        if(qty<=widget.singleProduct.qty-1)
                                        {qty++;}
                                        // qty++;
                              
                                      });
                                      appProvider.updateQty(widget.singleProduct, qty);
                                      

                                    },
                                    padding: EdgeInsets.zero,
                                    child: CircleAvatar(
                                      maxRadius: 12,
                                      child: Icon(Icons.add),
                                    ))
                              ],
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if(!appProvider.getFavouriteProductList
                                    .contains(widget.singleProduct)){
                                  appProvider.addFavouriteProduct(widget.singleProduct);
                                  
                                  showMessage("Added to wishlist");
                                }else{
                                  appProvider.removeFavouriteProduct(widget.singleProduct);
                                  showMessage("Removed from wishlist");

                                }

                              },
                              child: Text(
                                appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)
                                    ? "Remove from wishlist"
                                    : "Add to wishlist",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\Rs.${widget.singleProduct.price.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          showMessage("Removed from cart");
                        },
                        child: CircleAvatar(
                            maxRadius: 13,
                            child: Icon(
                              Icons.delete,
                              size: 17,
                            ))),
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
