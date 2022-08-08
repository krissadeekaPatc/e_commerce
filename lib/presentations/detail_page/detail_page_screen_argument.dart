import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:e_commerce_app/data/model/product_model.dart';

class DetailPageScreenArgument {
  String productName;
  String productCat;
  List<String> productImage;
  String detail;
  String productID;
  int price;
  List<ProductsModel> productList;
  List<CartModel> cartList;

  DetailPageScreenArgument({
    required this.detail,
    required this.productCat,
    required this.productID,
    required this.productImage,
    required this.productName,
    required this.price,
    required this.productList,
    required this.cartList,
  });
}
