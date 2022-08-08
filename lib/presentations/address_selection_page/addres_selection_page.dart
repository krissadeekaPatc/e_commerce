import 'dart:convert';

import 'package:e_commerce_app/common_widgets/common_box_data.dart';
import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/constant_key/address_selection_page.dart';
import 'package:e_commerce_app/data/model/address_model.dart';
import 'package:e_commerce_app/presentations/address_selection_page/address_selection_page_privider.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page_argument.dart';
import 'package:e_commerce_app/presentations/payment_selection_page/payment_selection_page_argument.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'address_selection_page_argument.dart';

class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AddressSelectionPageArgument?;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Address Selection"),
        backgroundColor: Colors.black,
      ),
      body: ChangeNotifierProvider(
        create: (c) => AddressSelectionPageProvider()..initialData(),
        child: Consumer<AddressSelectionPageProvider>(
            builder: (context, provider, _) {
          return Stack(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.addressData.length,
                  itemBuilder: (c, i) {
                    final data = provider.addressData[i];
                    return InkWell(
                      onTap: () {
                        provider.setValue(i);
                      },
                      child: Column(
                        children: [
                          CommonBoxData(
                            key: Key(
                                AddressSelectionPageConstantKey.addressListKey +
                                    i.toString()),
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.reciverName),
                                    Text(data.phoneNumber),
                                    Text(data.address1),
                                    Text(
                                        "${data.province}, ${data.district}, ${data.district}, ${data.postCode} "),
                                  ],
                                ),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Radio(
                                    key: Key(AddressSelectionPageConstantKey
                                            .radioButtonKey +
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
                          provider.addressData.length - 1 == i
                              ? InkWell(
                                  key: Key(AddressSelectionPageConstantKey
                                      .addNewAddressButtonKey),
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      "/input_address_page",
                                      arguments: InputAddressPageArgument(
                                          addressModel: provider.addressData),
                                    ).then((value) {
                                      provider.addedNewAddressData(
                                          value as List<AddressModel>);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 70),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Add new address",
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
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  key: Key(
                      AddressSelectionPageConstantKey.continuePaymentButtonKey),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/payment_page',
                      arguments: PaymentSelectionPageArgument(
                        totalAmount: args?.totalAmount ?? 0,
                        totalPrice: args?.totalPrice ?? 0,
                        addressData: provider.addressData[provider.index],
                      ),
                    );
                  },
                  textColor: Colors.white,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Continue Payment",
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
