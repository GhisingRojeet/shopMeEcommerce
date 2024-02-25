// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/categories_view/add_category/add_category.dart';
import 'package:admin_panel/screens/categories_view/widget/single_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories view"),
        actions: [
          IconButton(onPressed: (){Routes.instance.push(widget: AddCategory(), context: context);}, icon: Icon(Icons.add_circle,color: Colors.black,)),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: value.getCategories.length,
                      itemBuilder: (context, index) {
                        CategoryModel categoryModel =
                            value.getCategories[index];
                        return singleCategoryItem(singleCategory: categoryModel,index: index,);
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
