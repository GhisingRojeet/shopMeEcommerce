// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

AdminModel AdminModelFromJson(String str) =>
   AdminModel.fromJson(json.decode(str));

String uAdminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  AdminModel({
     
    required this.id,
    required this.name,
    required this.email,
    
  });

  String? image;
  String name;
  String email;
  String id;
  

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json["id"],
  
    email: json["email"],
    name: json["name"],
  

  );

  Map<String, dynamic> toJson() => {
    "id": id,
   
    "name": name,
    "email": email,
  };



 AdminModel copyWith({
    String? name,image,
  }) =>
      AdminModel(
        id: id,
        name: name??this.name,
          email:email,
         
          

      );
}
