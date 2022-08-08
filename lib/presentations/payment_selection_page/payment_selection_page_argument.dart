import 'package:e_commerce_app/data/model/address_model.dart';

class PaymentSelectionPageArgument {
  PaymentSelectionPageArgument({
    this.totalAmount = 0,
    this.totalPrice = 0,
    this.addressData,
  });

  int totalAmount;
  int totalPrice;
  AddressModel? addressData;
}
