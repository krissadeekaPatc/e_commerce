import 'dart:convert';

import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartCheckOutProvider extends ChangeNotifier {
  List<CartModel> cartData = [];
  List<CartModel> displayList = [];
  bool isLoading = true;
  initialData() async {
    // await readJsonFile();
  }

  Future<List<CartModel>> readJsonFile() async {
    final String response =
        await rootBundle.loadString("assets/data/cart_data.json");
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  toggleIsLoading() {
    isLoading = false;
    notifyListeners();
  }

  CartModel sumTotalProducts(List<CartModel> list) {
    if (list.isEmpty) {
      return CartModel(
        productName: "Total Product",
        productId: "Total Product",
        price: 0,
        category: "SUM",
        productImage: "",
        amount: 0,
      );
    }
    return list.reduce(
      (value, element) => CartModel(
        productName: "Total Product",
        productId: "Total Product",
        price: value.price + element.price,
        category: "SUM",
        productImage: "",
        amount: value.amount + element.amount,
      ),
    );
  }
}
