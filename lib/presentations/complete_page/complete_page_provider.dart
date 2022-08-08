import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class CompletePageProvider with ChangeNotifier {
  Future clearCart() async {
    File file = File(
        '/Users/nonzenithz/e_commerce_app/e_commerce_app/assets/data/cart_data.json');
    final clearedData = json.encode([]);
    await file.writeAsString(clearedData);
    notifyListeners();
  }
}
