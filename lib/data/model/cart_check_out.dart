// To parse this JSON data, do
//
//     final CartModel = CartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  CartModel({
    required this.productName,
    required this.productId,
    required this.price,
    required this.category,
    required this.productImage,
    required this.amount,
  });

  String productName;
  String productId;
  int price;
  String category;
  String productImage;
  int amount;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productName: json["productName"],
        productId: json["productID"],
        price: json["price"],
        category: json["category"],
        productImage: json["productImage"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productID": productId,
        "price": price,
        "category": category,
        "productImage": productImage,
        "amount": amount,
      };
}
