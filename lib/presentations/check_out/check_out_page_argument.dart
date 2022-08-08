import 'package:e_commerce_app/data/model/address_model.dart';
import 'package:e_commerce_app/data/model/payment_model.dart';

class CheckOutPageArgument {
  CheckOutPageArgument({
    required this.totalAmount,
    required this.totalPrice,
    required this.addressData,
    required this.paymentData,
  });

  int totalAmount;
  int totalPrice;
  AddressModel addressData;
  PaymentModel paymentData;
}
