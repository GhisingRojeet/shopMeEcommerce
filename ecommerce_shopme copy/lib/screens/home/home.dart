// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unnecessary_string_escapes

import 'package:ecommerce_shopme/constants/routes.dart';
import 'package:ecommerce_shopme/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_shopme/models/category_model/category_model.dart';
import 'package:ecommerce_shopme/provider/app_provider.dart';
import 'package:ecommerce_shopme/screens/category_view/category_view.dart';
import 'package:ecommerce_shopme/screens/product_details/product_details.dart';
import 'package:ecommerce_shopme/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model/product_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    if(mounted){
       setState(() {
      isLoading = false;
    });
    }

   
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopTitles(title: "ShopMe", subtitle: ""),
                        TextFormField(
                          controller: search,
                          onChanged: (String value){
                            searchProducts(value);
                          },
                          decoration: InputDecoration(hintText: "Search..."),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  SizedBox(
                    height: 12.0,
                  ),
                  !isSearched()?
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "Best Products",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ):SizedBox.fromSize(),
                  SizedBox(
                    height: 12.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty? Center(child: Text("No Products Found"),):searchList.isNotEmpty? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.only(bottom: 50),
                        itemCount: searchList.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.7),
                        itemBuilder: (ctx, index) {
                          ProductModel singleProduct =
                          searchList[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Image.network(
                                  singleProduct.image,
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  singleProduct.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Price: \Rs.${singleProduct.price}"),
                                SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(
                                    height: 45,
                                    width: 140,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: ProductDetails(
                                                singleProduct:
                                                singleProduct),
                                            context: context);
                                      },
                                      child: Text("Buy"),
                                    )),
                              ],
                            ),
                          );
                        }),
                  ):
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Best Products are empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: const EdgeInsets.only(bottom: 50),
                              itemCount: productModelList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.7),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        singleProduct.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Price: \Rs.${singleProduct.price}"),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context: context);
                                            },
                                            child: Text("Buy"),
                                          )),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
  bool isSearched(){
    if(search.text.isNotEmpty && searchList.isEmpty){
      return true;
    }else if(search.text.isEmpty && searchList.isNotEmpty){
      return false;
    }
    else if( searchList.isNotEmpty) {
      return true;
    }
    else{
      return false;
    }
  }
}
