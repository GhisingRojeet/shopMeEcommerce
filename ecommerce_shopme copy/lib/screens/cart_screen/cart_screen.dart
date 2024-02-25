// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, sized_box_for_whitespace, unnecessary_string_escapes

import 'package:ecommerce_shopme/constants/constants.dart';
import 'package:ecommerce_shopme/constants/routes.dart';
import 'package:ecommerce_shopme/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:ecommerce_shopme/screens/cart_screen/widgets/single_cart_item.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=  Provider.of<AppProvider>(context);

    return Scaffold(
      bottomNavigationBar: Container(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                  Text("\Rs${appProvider.totalPrice().toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),

                ],
              ),
              SizedBox(height: 24.0,),
              PrimaryButton( title: "Checkout",onPressed: (){
                appProvider.clearBuyProduct();
                appProvider.addBuyProductCartList();
                appProvider.clearCart();
                if(appProvider.getBuyProductList.isEmpty){
                  showMessage("Cart is empty");
                }else{Routes.instance.push(widget: CartItemCheckout(), context: context);
                }
              },)
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty?Center(child: Text("Shop more with shopMe",style: TextStyle(fontWeight: FontWeight.bold),),)
          :ListView.builder(
        padding: EdgeInsets.all(12.0),
          itemCount: appProvider.getCartProductList.length,
          itemBuilder: (ctx, index) {
            return SingleCartItem(singleProduct: appProvider.getCartProductList[index],);
          }),
    );
  }
}
