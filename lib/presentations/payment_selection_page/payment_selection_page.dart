import 'package:e_commerce_app/common_widgets/common_box_data.dart';
import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/constant_key/payment_selection_page.dart';
import 'package:e_commerce_app/data/model/address_model.dart';
import 'package:e_commerce_app/data/model/payment_model.dart';
import 'package:e_commerce_app/presentations/check_out/check_out_page_argument.dart';
import 'package:e_commerce_app/presentations/input_payment_menthod_page/input_payment_page_argument.dart';
import 'package:e_commerce_app/presentations/payment_selection_page/payment_selection_page_argument.dart';
import 'package:e_commerce_app/presentations/payment_selection_page/payment_selection_page_privider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentSelectionPage extends StatelessWidget {
  const PaymentSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as PaymentSelectionPageArgument?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Payment Selection"),
      ),
      body: ChangeNotifierProvider(
        create: (c) => PaymentSelectionPageProvider()..initialData(),
        child: Consumer<PaymentSelectionPageProvider>(
            builder: (context, provider, _) {
          return Stack(
            children: [
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.paymentData.length,
                      itemBuilder: (c, i) {
                        final data = provider.paymentData[i];
                        return InkWell(
                          key: Key(
                              PaymentSelectionPageConstantKey.paymentListKey +
                                  i.toString()),
                          onTap: () {
                            provider.setValue(i);
                          },
                          child: Column(
                            children: [
                              CommonBoxData(
                                widget: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Card Holder Name" +
                                            data.cardHolderName),
                                        Text("Card No. : " + data.cardNo),
                                        Text("Bank Name: " + data.bankName),
                                        Text("Expired Data: " +
                                            data.expiredDate),
                                      ],
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        key: Key(PaymentSelectionPageConstantKey
                                                .radioButtonKey +
                                            i.toString()),
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.black),
                                        value: i,
                                        groupValue: provider.index,
                                        onChanged: (int? value) {
                                          provider.setValue(value!);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              provider.paymentData.length - 1 == i
                                  ? InkWell(
                                      key: Key(PaymentSelectionPageConstantKey
                                          .addNewPaymentButtonKey),
                                      onTap: () async {
                                        await Navigator.pushNamed(
                                                context, "/input_payment_page",
                                                arguments:
                                                    InputPaymentPageArgument(
                                                        paymentModel: provider
                                                            .paymentData))
                                            .then((value) {
                                          provider.addedNewPaymentData(
                                              value as List<PaymentModel>);
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 70),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Add new payment",
                                              style: TextStyle(fontSize: 23),
                                            ),
                                            SizedBox(width: 20),
                                            Icon(
                                              Icons.add_circle_outline_outlined,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      }),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  key: Key(PaymentSelectionPageConstantKey.checkOutButtonKey),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/check_out_page',
                      arguments: CheckOutPageArgument(
                        totalAmount: args?.totalAmount ?? 0,
                        totalPrice: args?.totalPrice ?? 0,
                        addressData: args?.addressData ?? AddressModel(),
                        paymentData: provider.paymentData[provider.index],
                      ),
                    );
                  },
                  textColor: Colors.white,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Check Out!",
                        style: GoogleFonts.ibarraRealNova(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
