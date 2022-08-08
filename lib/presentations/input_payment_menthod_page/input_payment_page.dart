import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page_argument.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page_provider.dart';
import 'package:e_commerce_app/presentations/input_payment_menthod_page/input_payment_page_argument.dart';
import 'package:e_commerce_app/presentations/input_payment_menthod_page/input_payment_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputPaymentPage extends StatelessWidget {
  const InputPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as InputPaymentPageArgument;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Input Payment"),
      ),
      body: ChangeNotifierProvider(
        create: (c) =>
            InputPaymentPageProvider()..initialData(args.paymentModel),
        child:
            Consumer<InputPaymentPageProvider>(builder: (context, provider, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                  child: Container(
                child: Column(
                  children: [
                    buildTextField(
                      title: "Card Holder Name",
                      onChanged: (v) => provider.onCardHolderNameChange(v),
                    ),
                    buildTextField(
                      title: "Card No",
                      onChanged: (v) => provider.onCardNoChange(v),
                    ),
                    buildTextField(
                      title: "Bank Name",
                      onChanged: (v) => provider.onBankNameChange(v),
                    ),
                    buildTextField(
                      title: "CVV",
                      onChanged: (v) => provider.onCvvChange(v),
                    ),
                    buildTextField(
                      title: "Expired Data",
                      onChanged: (v) => provider.onExpiredDateChange(v),
                    ),
                  ],
                ),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: () {
                    provider.onSave();
                    Navigator.pop(context, provider.paymentData);
                  },
                  color: Colors.black,
                  widget: Row(
                    children: const [
                      Icon(Icons.save),
                      SizedBox(width: 20),
                      Text("SAVE!")
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget buildTextField(
      {required String title, Function(String V)? onChanged}) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(flex: 1, child: Text(title)),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: TextField(
            onChanged: (v) {
              onChanged?.call(v);
            },
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
