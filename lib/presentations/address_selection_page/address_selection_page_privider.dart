import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/model/address_model.dart';

class AddressSelectionPageProvider with ChangeNotifier {
  List<AddressModel> addressData = [];
  bool isLoading = true;
  int index = 0;
  Future initialData() async {
    await readJsonFile();
    notifyListeners();
  }

  Future readJsonFile() async {
    final String response =
        await rootBundle.loadString("assets/data/address_data.json");
    final data = await json.decode(response) as List<dynamic>;
    isLoading = false;
    addressData = data.map((e) => AddressModel.fromJson(e)).toList();
    notifyListeners();
  }

  addedNewAddressData(List<AddressModel> addressData) {
    this.addressData = addressData;
    notifyListeners();
  }

  setValue(int value) {
    index = value;
    notifyListeners();
  }
}
