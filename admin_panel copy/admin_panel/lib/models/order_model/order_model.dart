import 'package:admin_panel/models/product_model/product_model.dart';



class OrderModel {
  OrderModel({
    required this.payment,
    required this.status,
    required this.totalPrice,
    required this.orderId,
    required this.products,
    required this.userId,
   
  });

  String payment;
  String status;
  double totalPrice;
  List<ProductModel> products;
  String orderId;
  String userId;
 

  factory OrderModel.fromJson(Map<String, dynamic> json){
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json["orderId"],
      userId: json["userId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
      status: json["status"],
      payment: json["payment"],
     

    );
  }

}
