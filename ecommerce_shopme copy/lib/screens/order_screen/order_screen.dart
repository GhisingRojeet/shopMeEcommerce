// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes

import 'package:ecommerce_shopme/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_shopme/models/order_model/order_model.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  
  get singleProduct => null;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Your orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.isEmpty ||
                snapshot.data == null ||
                !snapshot.hasData) {
              return Center(
                child: Text("No Order Found"),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    OrderModel orderModel = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        tilePadding: EdgeInsets.zero,
                        collapsedShape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.3)),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.3)),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              color: Colors.red.withOpacity(0.6),
                              child:
                                  Image.network(orderModel.products[0].image),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.products[0].name,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  orderModel.products.length > 1
                                      ? SizedBox.fromSize()
                                      : Column(
                                          children: [
                                            Text(
                                              "Quantity:${orderModel.products[0].qty.toString()}",
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                          ],
                                        ),
                                  Text(
                                    "Total Price:\Rs.${orderModel.totalPrice.toString()}",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    "Status:${orderModel.status}",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  orderModel.status == "Pending"
                                  ||
                                  orderModel.status =="Delivery"
                                      ? 
                                      ElevatedButton(
                                          onPressed: () async{
                                          await FirebaseFirestoreHelper.instance
                                                .updateOrder(
                                                    orderModel, "Cancelled");
                                                    orderModel.status = "Cancelled";
                                                    setState(() {
                                                      
                                                    });
                                          },
                                          child: Text("Cancel Order"))
                                      : SizedBox.fromSize(),
                                
                                
                                  orderModel.status =="Delivery"
                                      ? 
                                      ElevatedButton(
                                          onPressed: () async{
                                          await FirebaseFirestoreHelper.instance
                                                .updateOrder(
                                                    orderModel, "Completed");
                                                    orderModel.status = "Completed";
                                                    setState(() {
                                        
                                                      
                                                    });
                                          },
                                          child: Text("Delivered"))
                                      : SizedBox.fromSize(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        children: orderModel.products.length > 1
                            ? [
                                Text("Details"),
                                Divider(color: Theme.of(context).primaryColor),
                                ...orderModel.products.map((singleProduct) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 6.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              color:
                                                  Colors.red.withOpacity(0.6),
                                              child: Image.network(
                                                  singleProduct.image),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    singleProduct.name,
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                  ),
                                                  SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Quantity:${singleProduct.qty.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 12.0),
                                                      ),
                                                      SizedBox(
                                                        height: 12.0,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Price:\Rs.${singleProduct.price.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ],
                                    ),
                                  );
                                }).toList()
                              ]
                            : [],
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
