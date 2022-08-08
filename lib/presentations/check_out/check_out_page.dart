import 'package:e_commerce_app/common_widgets/common_box_data.dart';
import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/constant_key/check_out_page.dart';
import 'package:e_commerce_app/presentations/check_out/check_out_page_argument.dart';
import 'package:e_commerce_app/presentations/check_out/check_out_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPage({Key? key}) : super(key: key);
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CheckOutPageArgument;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out page"),
        backgroundColor: Colors.black,
      ),
      body: ChangeNotifierProvider(
        create: (context) => CheckOutPageProvider()..initialData(),
        child: Consumer<CheckOutPageProvider>(builder: ((context, provider, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      key: Key(CheckOutPageConstantKey.totalProductPriceKey),
                      "Total Product Price\n${myFormat.format(args.totalPrice)} AUD",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text("Address"),
                    CommonBoxData(
                      key: Key(CheckOutPageConstantKey.addressKey),
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(args.addressData.reciverName),
                              Text(args.addressData.phoneNumber),
                              Text(args.addressData.address1),
                              Text(
                                  "${args.addressData.province}, ${args.addressData.district}, ${args.addressData.district}, ${args.addressData.postCode} "),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text("Payment"),
                    CommonBoxData(
                      key: Key(CheckOutPageConstantKey.paymentKey),
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Card Holder Name" +
                              args.paymentData.cardHolderName),
                          Text("Card No. : " + args.paymentData.cardNo),
                          Text("Bank Name: " + args.paymentData.bankName),
                          Text("Expired Data: " + args.paymentData.expiredDate),
                        ],
                      ),
                    ),
                    const Text("Select Shipping Type"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.shippingType.length,
                      itemBuilder: (c, i) {
                        final data = provider.shippingType[i];
                        return InkWell(
                          key: Key(CheckOutPageConstantKey.shippingTypeListKey +
                              i.toString()),
                          onTap: () {
                            provider.setValue(i);
                          },
                          child: CommonBoxData(
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Shipping Type : ${data.type}"),
                                    Text("Price : ${data.price} AUD"),
                                    Text(
                                        "Estimated Time : ${data.estimatedTime}"),
                                    Text("Company Name : ${data.companyName}"),
                                  ],
                                ),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Radio(
                                    key: Key(
                                        CheckOutPageConstantKey.radioButtonKey +
                                            i.toString()),
                                    fillColor: MaterialStateColor.resolveWith(
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
                        );
                      },
                    ),
                    Text(
                      key: Key(CheckOutPageConstantKey.totalPriceKey),
                      "Total Price (Including Shipping price)\n${myFormat.format(args.totalPrice + provider.shippingType[provider.index].price)} AUD",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  key: Key(CheckOutPageConstantKey.confirmButtonKey),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (c) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: const Center(
                                  child: Text(
                                    "Do you want to confirm payment ?",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        borderRadius: 20,
                                        textTitle: "Cancel",
                                        onPressed: () {
                                          Navigator.pop(c);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        borderRadius: 20,
                                        textTitle: "Confirm !",
                                        textColor: Colors.white,
                                        color: Colors.black,
                                        onPressed: () async {
                                          Navigator.pop(c);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              "/complete_page",
                                              (route) => false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  textTitle: "Confrim Payment",
                  textColor: Colors.white,
                  color: Colors.black,
                ),
              )
            ],
          );
        })),
      ),
    );
  }
}
