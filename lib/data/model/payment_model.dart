// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel({
    this.cardNo = '',
    this.cardHolderName = '',
    this.cvv = '',
    this.expiredDate = '',
    this.bankName = '',
  });

  String cardNo;
  String cardHolderName;
  String cvv;
  String expiredDate;
  String bankName;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        cardNo: json["card_no"],
        cardHolderName: json["card_holder_name"],
        cvv: json["cvv"],
        expiredDate: json["expired_date"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "card_no": cardNo,
        "card_holder_name": cardHolderName,
        "cvv": cvv,
        "expired_date": expiredDate,
        "bank_name": bankName,
      };
}
