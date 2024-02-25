import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.isFavourite,
      required this.categoryId,
      required this.qty
      });
  String image;
  String id,categoryId;
  bool isFavourite;
  String name;
  double price;
  String description;
  double qty;
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"].toString(),
        name: json["name"],
        categoryId: json["categoryId"]??"",
        description: json["description"],
        qty: double.parse(json["qty"].toString()),
        image: json["image"],
        isFavourite: false,
        price: double.parse(
          json["price"].toString(),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "categoryId": categoryId,
        "isFavourite": isFavourite,
        "price": price,
    "qty":qty
      };



      ProductModel copyWith({
    String? name,
    String?image,
    String?id,
    String?categoryId,
    String?description,
    String? price,
    String? qty

  }) =>
      ProductModel(
        id: id?? this.id,
        name: name??this.name,
          categoryId: categoryId?? this.categoryId,
          image: image??this.image,
          isFavourite: false,
          description: description?? this.description,
          price: price !=null? double.parse(price):this.price,
          qty: qty !=null? double.parse(qty):this.qty

      );
}
  


