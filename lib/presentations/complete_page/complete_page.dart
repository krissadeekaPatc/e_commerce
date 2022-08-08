import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/presentations/complete_page/complete_page_provider.dart';
import 'package:e_commerce_app/presentations/home_page/home_page_argument.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (c) => CompletePageProvider(),
        child: Consumer<CompletePageProvider>(builder: (context, provider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Icon(
                  Icons.check_circle_outlined,
                  size: 90,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Order Complete",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 160),
                CustomButton(
                  key: Key("ABC"),
                  onPressed: () async {
                    print("Tapped");
                    await provider.clearCart();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => false,
                        arguments: HomePageArgument(isComplete: true));
                  },
                  textTitle: "Back To Home Page",
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
