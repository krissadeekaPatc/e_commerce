import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/constant_key/cart_page.dart';
import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:e_commerce_app/presentations/address_selection_page/address_selection_page_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cart_check_out_provider.dart';
import 'cart_check_out_screen_argument.dart';

class CartCheckOutScreen extends StatelessWidget {
  const CartCheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final args = ModalRoute.of(context)!.settings.arguments
        as CartCheckOutScreenArguments;
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartCheckOutProvider()..initialData(),
      child: Consumer<CartCheckOutProvider>(builder: (context, data, _) {
        final sumTotalProducts = data.sumTotalProducts(args.cartList);
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Cart"),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: args.cartList.length,
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    final data = args.cartList[i];
                    return Column(
                      key: Key(
                          CartPageConstantKey.productListKey + i.toString()),
                      children: [
                        Slidable(
                          closeOnScroll: true,
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            extentRatio: 0.3,
                            dragDismissible: false,
                            motion: const DrawerMotion(),
                            closeThreshold: 0.5,
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: [
                              SlidableAction(
                                autoClose: false,
                                spacing: 10,
                                onPressed: (c) {},
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: Image(
                                    image:
                                        Image.network(data.productImage).image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.productName),
                                    Text("Amount: ${data.amount}"),
                                    Text("Price: ${data.price}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: (i == args.cartList.length - 1) ? 110 : 20)
                      ],
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              key: Key(CartPageConstantKey.totalAmountKey),
                              "Total Amount: ${sumTotalProducts.amount} "),
                          Text(
                              key: Key(CartPageConstantKey.totalPriceKey),
                              "Total Price:  ${myFormat.format(sumTotalProducts.price)}  AUD "),
                        ],
                      ),
                    ),
                    CustomButton(
                      key: Key(CartPageConstantKey.makePaymentButtonKey),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/address_page',
                          arguments: AddressSelectionPageArgument(
                            totalAmount: sumTotalProducts.amount,
                            totalPrice: sumTotalProducts.price,
                          ),
                        );
                      },
                      textColor: Colors.white,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Make a Payment",
                            style: GoogleFonts.ibarraRealNova(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
