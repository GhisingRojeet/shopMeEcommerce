

import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/categories_view.dart';
import 'package:admin_panel/screens/home_page/widgets/single_dash_item.dart';
import 'package:admin_panel/screens/order_list/order_list.dart';
import 'package:admin_panel/screens/product_view/product_view.dart';
import 'package:admin_panel/screens/user_view/user_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
          
                        CupertinoButton(
                          onPressed: (){

                        FirebaseAuthHelper.instance.signOut();
                        setState(() {});
                      

                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            color: Colors.blueAccent,
                            child: const Center(child: Text("Log Out",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black),))))
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      "admin",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "admin123@gmail.com",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12.0,),
                    // ElevatedButton(onPressed: (){

                    // }, child: Text("Send notification")),

                    //grid view layout
                    GridView.count(
                      padding: const EdgeInsets.only(top: 12.0),
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        SingleDashItem(
                            title: appProvider.getUserList.length.toString(),
                            onPressed: () {
                              Routes.instance
                                  .push(widget: const UserView(), context: context);
                            },
                            subtitle: "Users"),
                        SingleDashItem(
                            title:
                                appProvider.getCategories.length.toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: const CategoriesView(), context: context);
                            },
                            subtitle: "Categories"),
                        SingleDashItem(
                            title: appProvider.getProducts.length.toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: const ProductView(), context: context);
                            },
                            subtitle: "Products"),
                        SingleDashItem(
                            title: "Rs.${appProvider.getTotalEarning}",
                            onPressed: () {},
                            subtitle: "Earning"),
                        SingleDashItem(
                            title: appProvider.getPendingOrderList.length
                                .toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      orderModelList:
                                          appProvider.getPendingOrderList,
                                      title: "Pending"),
                                  context: context);
                            },
                            subtitle: "Pending Order"),
                        SingleDashItem(
                            title: appProvider.getDeliveryOrderList.length
                                .toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      orderModelList:
                                          appProvider.getDeliveryOrderList,
                                      title: "Delivery"),
                                  context: context);
                            },
                            subtitle: "Deliver Order"),
                        SingleDashItem(
                            title: appProvider.getCancelOrderList.length
                                .toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                      orderModelList:
                                          appProvider.getCancelOrderList,
                                      title: "Cancelled"),
                                  context: context);
                            },
                            subtitle: "Cancel order"),
                        SingleDashItem(
                            title: appProvider.getCompletedOrderList.length
                                .toString(),
                            onPressed: () {
                              Routes.instance.push(
                                  widget: OrderList(
                                    orderModelList:
                                        appProvider.getCompletedOrderList,
                                    title: "Completed",
                                  ),
                                  context: context);
                            },
                            subtitle: "Completed Order"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
