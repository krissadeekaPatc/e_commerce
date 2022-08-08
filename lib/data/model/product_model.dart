// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) =>
    List<ProductsModel>.from(
        json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  ProductsModel({
    required this.productName,
    required this.productId,
    required this.price,
    required this.detail,
    required this.category,
    required this.productImage,
  });

  String productName;
  String productId;
  int price;
  String detail;
  String category;
  List<String> productImage;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        productName: json["productName"],
        productId: json["productID"],
        price: json["price"],
        detail: json["detail"],
        category: json["category"],
        productImage: List<String>.from(json["productImage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productID": productId,
        "price": price,
        "detail": detail,
        "category": category,
        "productImage": List<dynamic>.from(productImage.map((x) => x)),
      };
}
