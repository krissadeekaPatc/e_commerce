import 'package:e_commerce_app/data/model/address_model.dart';

class PaymentSelectionPageArgument {
  PaymentSelectionPageArgument({
    required this.totalAmount,
    required this.totalPrice,
    required this.addressData,
  });

  int totalAmount;
  int totalPrice;
  AddressModel addressData;
}
