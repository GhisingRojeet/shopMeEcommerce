// ignore_for_file: must_be_immutable, prefer_const_constructors, unnecessary_string_escapes

import 'package:admin_panel/helpers/firebase_firestore_helper/firebase_firestore.dart';
import 'package:admin_panel/models/order_model/order_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleOrderWidget extends StatefulWidget {
  final OrderModel orderModel;

  const SingleOrderWidget({super.key, required this.orderModel});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        collapsedShape: RoundedRectangleBorder(
            side:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.3)),
        shape: RoundedRectangleBorder(
            side:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.3)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              color: Colors.blue.withOpacity(0.6),
              child: Image.network(widget.orderModel.products[0].image),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderModel.products[0].name,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    widget.orderModel.products.length > 1
                        ? SizedBox.fromSize()
                        : Column(
                            children: [
                              Text(
                                "Quantity:${widget.orderModel.products[0].qty.toString()}",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                            ],
                          ),
                    Text(
                      "Total Price:\Rs.${widget.orderModel.totalPrice.toString()}",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Order Status:${widget.orderModel.status}",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    widget.orderModel.status == "Pending"
                        ? CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await FirebaseFirestoreHelper.instance
                                  .updateOrder(widget.orderModel, "Delivery");
                              widget.orderModel.status = "Delivery";
                              appProvider.updatePendingOrder(widget.orderModel);
                              appProvider.updateQty(
                                  widget.orderModel.products[0].id,
                                  widget.orderModel);
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Text(
                                "Send to Delivery",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox.fromSize(),
                    widget.orderModel.status == "Pending" ||
                            widget.orderModel.status == "Delivery"
                        ? CupertinoButton(
                            onPressed: () async {
                              if (widget.orderModel.status == "Pending") {
                                widget.orderModel.status = "Cancelled";
                                await FirebaseFirestoreHelper.instance
                                    .updateOrder(
                                        widget.orderModel, "Cancelled");
                                appProvider.updateCancelPendingOrder(
                                    widget.orderModel);
                              } else {
                                widget.orderModel.status = "Cancelled";
                                await FirebaseFirestoreHelper.instance
                                    .updateOrder(
                                        widget.orderModel, "Cancelled");
                                appProvider.cancelQty(
                                    widget.orderModel.products[0].id,
                                    widget.orderModel);

                                appProvider.updateCancelDeliveryOrder(
                                    widget.orderModel);
                              }
                              setState(() {});
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Text(
                                "Cancel Order ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox.fromSize()
                  ],
                ),
              ),
            ),
          ],
        ),
        children: widget.orderModel.products.length > 1
            ? [
                Text("Details"),
                Divider(color: Theme.of(context).primaryColor),
                ...widget.orderModel.products.map((singleProduct) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              color: Colors.red.withOpacity(0.6),
                              child: Image.network(singleProduct.image),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    singleProduct.name,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Quantity:${singleProduct.qty.toString()}",
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Price:\Rs.${singleProduct.price.toString()}",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Theme.of(context).primaryColor),
                      ],
                    ),
                  );
                }).toList()
              ]
            : [],
      ),
    );
  }
}
