import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/data/model/address_model.dart';
import 'package:e_commerce_app/data/model/payment_model.dart';
import 'package:flutter/foundation.dart';

class InputPaymentPageProvider with ChangeNotifier {
  String cardHolderName = "";
  String cardNo = "";
  String bankName = "";
  String expiredDate = "";
  String cvv = "";

  List<PaymentModel> paymentData = [];
  initialData(List<PaymentModel> list) {
    paymentData = list;
    notifyListeners();
  }

  onCardHolderNameChange(String text) {
    cardHolderName = text;
    notifyListeners();
  }

  onCvvChange(String text) {
    cvv = text;
    notifyListeners();
  }

  onBankNameChange(String text) {
    bankName = text;
    notifyListeners();
  }

  onExpiredDateChange(String text) {
    expiredDate = text;
    notifyListeners();
  }

  onCardNoChange(String text) {
    cardNo = text;
    notifyListeners();
  }

  Future onSave() async {
    File file = File(
        '/Users/nonzenithz/e_commerce_app/e_commerce_app/assets/data/payment_data.json');
    PaymentModel model = PaymentModel(
      bankName: bankName,
      cardHolderName: cardHolderName,
      cardNo: cardNo,
      cvv: cvv,
      expiredDate: expiredDate,
    );
    paymentData.add(model);
    final result = json.encode(paymentData);
    notifyListeners();
    await file.writeAsString(result);
  }
}
