import 'package:e_commerce_app/presentations/address_selection_page/addres_selection_page.dart';
import 'package:e_commerce_app/presentations/address_selection_page/address_selection_page_privider.dart';
import 'package:e_commerce_app/presentations/check_out/check_out_page.dart';
import 'package:e_commerce_app/presentations/complete_page/complete_page.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page.dart';
import 'package:e_commerce_app/presentations/input_payment_menthod_page/input_payment_page.dart';
import 'package:e_commerce_app/presentations/payment_selection_page/payment_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentations/cart_page/cart_check_out_screen.dart';
import 'presentations/detail_page/detail_page_screen.dart';
import 'presentations/home_page/home_page.dart';

class AppRoutes extends StatelessWidget {
  final String initialRoute;
  const AppRoutes({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.ibarraRealNova().fontFamily,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "/home": (c) => const HomePage(),
        "/detail_page": (c) => const DetailPageScreen(),
        "/cart_page": (c) => const CartCheckOutScreen(),
        "/check_out_page": (c) => CheckOutPage(),
        "/address_page": (c) => const AddressSelectionPage(),
        "/payment_page": (c) => const PaymentSelectionPage(),
        "/input_address_page": (c) => const InputAddressPage(),
        "/input_payment_page": (c) => const InputPaymentPage(),
        "/complete_page": (context) => const CompletePage(),
      },
    );
  }
}
