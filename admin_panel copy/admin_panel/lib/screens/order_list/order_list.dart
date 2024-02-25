// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:admin_panel/models/order_model/order_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/user_view/widgets/single_order_widget/single_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
 final List<OrderModel> orderModelList;
 final String title;
   const OrderList({super.key,required this.orderModelList,required this.title});

List<OrderModel> getOrderList(AppProvider appProvider){
  if(title=="Pending"){
    return appProvider.getPendingOrderList;
  }
  else if(title =="Completed"){
        return appProvider.getCompletedOrderList;

  }
  else if(title =="Cancelled"){
        return appProvider.getCancelOrderList;

  }
  else if(title =="Delivery"){
        return appProvider.getDeliveryOrderList;

  }
  else{
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
        AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(" $title Order List"),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child:
        getOrderList(appProvider).isEmpty?Center(child: Text("$title is empty"),):
        ListView.builder(
          itemCount: getOrderList(appProvider).length,
          itemBuilder: (context,index){
            OrderModel orderModel = getOrderList(appProvider)[index];
            
            return SingleOrderWidget(orderModel: orderModel);
          }),
      )
    );
  }
}