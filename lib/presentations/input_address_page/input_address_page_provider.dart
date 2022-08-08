import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/data/model/address_model.dart';
import 'package:flutter/foundation.dart';

class InputAddressPageProvider with ChangeNotifier {
  String address = "";
  String province = "";
  String district = "";
  String subDistrict = "";
  String postCode = "";
  String phoneNumber = "";
  String recieverName = "";

  List<AddressModel> addressData = [];
  initialData(List<AddressModel> list) {
    addressData = list;
    notifyListeners();
  }

  onNameChange(String text) {
    recieverName = text;
    notifyListeners();
  }

  onAddressChange(String text) {
    address = text;
    notifyListeners();
  }

  onDistrictChange(String text) {
    district = text;
    notifyListeners();
  }

  onSubDistrictChange(String text) {
    subDistrict = text;
    notifyListeners();
  }

  onPhoneNumberChange(String text) {
    phoneNumber = text;
    notifyListeners();
  }

  onProvinceChange(String text) {
    province = text;
    notifyListeners();
  }

  onPostCodeChange(String text) {
    postCode = text;
    notifyListeners();
  }

  Future onSave() async {
    File file = File(
        '/Users/nonzenithz/e_commerce_app/e_commerce_app/assets/data/address_data.json');
    AddressModel model = AddressModel(
      address1: address,
      district: district,
      phoneNumber: phoneNumber,
      province: province,
      postCode: postCode,
      reciverName: recieverName,
      subDistrict: subDistrict,
    );
    addressData.add(model);
    final result = json.encode(addressData);
    notifyListeners();
    await file.writeAsString(result);
  }
}
