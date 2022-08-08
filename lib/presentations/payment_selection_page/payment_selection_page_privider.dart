import 'dart:convert';

import 'package:e_commerce_app/data/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentSelectionPageProvider with ChangeNotifier {
  List<PaymentModel> paymentData = [];
  bool isLoading = true;
  int index = 0;
  Future initialData() async {
    await readJsonFile();
    notifyListeners();
  }

  Future readJsonFile() async {
    final String response =
        await rootBundle.loadString("assets/data/payment_data.json");
    final data = await json.decode(response) as List<dynamic>;
    isLoading = false;
    paymentData = data.map((e) => PaymentModel.fromJson(e)).toList();
    notifyListeners();
  }

  addedNewPaymentData(List<PaymentModel> paymentData) {
    this.paymentData = paymentData;
    notifyListeners();
  }

  setValue(int value) {
    index = value;
    notifyListeners();
  }
}
