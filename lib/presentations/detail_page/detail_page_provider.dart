import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:flutter/material.dart';

class DetailPageProvider with ChangeNotifier {
  List<CartModel> cart = [];
  List<CartModel> finalCart = [];
  initalData({required List<CartModel> cartList}) async {
    cart = cartList;
    notifyListeners();
  }

  Future writeJsonFile({
    required String category,
    required int price,
    required String productId,
    required String productName,
    required String productImage,
    required int amount,
  }) async {
    final CartModel cartModel = CartModel(
      category: category,
      price: price,
      productId: productId,
      productImage: productImage,
      productName: productName,
      amount: amount,
    );
    cart.add(cartModel);

    File file = File(
        '/Users/nonzenithz/e_commerce_app/e_commerce_app/assets/data/cart_data.json');
    var totalCart = json.encode(cart);
    notifyListeners();
    await file.writeAsString(totalCart);
  }
}
