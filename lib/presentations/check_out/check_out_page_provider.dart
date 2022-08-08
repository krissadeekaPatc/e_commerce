import 'package:flutter/material.dart';

import '../../data/model/shipping_type_model.dart';

class CheckOutPageProvider with ChangeNotifier {
  List<ShippingTypeModel> shippingType = [];
  int index = 0;
  initialData() {
    shippingType.addAll(
      [
        ShippingTypeModel(
          type: "Standard",
          price: 20,
          companyName: "FEDEX",
          estimatedTime: "5-7 days",
        ),
        ShippingTypeModel(
          type: "Express",
          price: 70,
          companyName: "FEDEX",
          estimatedTime: "1-3 days",
        ),
      ],
    );

    notifyListeners();
  }

  setValue(int value) {
    index = value;
    notifyListeners();
  }
}
