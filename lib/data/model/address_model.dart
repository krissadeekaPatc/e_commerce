// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    this.address1 = '',
    this.address2 = '',
    this.province = '',
    this.district = '',
    this.subDistrict = '',
    this.postCode = '',
    this.phoneNumber = '',
    this.reciverName = '',
  });

  String address1;
  String address2;
  String province;
  String district;
  String subDistrict;
  String postCode;
  String phoneNumber;
  String reciverName;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
      address1: json["address_1"],
      address2: json["address_2"],
      province: json["province"],
      district: json["district"],
      subDistrict: json["sub_district"],
      postCode: json["post_code"],
      phoneNumber: json["phone_number"],
      reciverName: json["reciever_name"]);

  Map<String, dynamic> toJson() => {
        "address_1": address1,
        "address_2": address2,
        "province": province,
        "district": district,
        "sub_district": subDistrict,
        "post_code": postCode,
        "phone_number": phoneNumber,
        "reciever_name": reciverName,
      };
}
