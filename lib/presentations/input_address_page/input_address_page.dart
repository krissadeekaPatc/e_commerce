import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page_argument.dart';
import 'package:e_commerce_app/presentations/input_address_page/input_address_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputAddressPage extends StatelessWidget {
  const InputAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as InputAddressPageArgument;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Input Address"),
      ),
      body: ChangeNotifierProvider(
        create: (c) =>
            InputAddressPageProvider()..initialData(args.addressModel),
        child:
            Consumer<InputAddressPageProvider>(builder: (context, provider, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                  child: Container(
                child: Column(
                  children: [
                    buildTextField(
                      title: "Reciever Name",
                      onChanged: (v) => provider.onNameChange(v),
                    ),
                    buildTextField(
                      title: "Address",
                      onChanged: (v) => provider.onAddressChange(v),
                    ),
                    buildTextField(
                      title: "Phone Number",
                      onChanged: (v) => provider.onPhoneNumberChange(v),
                    ),
                    buildTextField(
                      title: "Province",
                      onChanged: (v) => provider.onProvinceChange(v),
                    ),
                    buildTextField(
                      title: "District",
                      onChanged: (v) => provider.onDistrictChange(v),
                    ),
                    buildTextField(
                      title: "Sub-District",
                      onChanged: (v) => provider.onSubDistrictChange(v),
                    ),
                    buildTextField(
                      title: "Postcode",
                      onChanged: (v) => provider.onPostCodeChange(v),
                    ),
                  ],
                ),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: () {
                    provider.onSave();
                    Navigator.pop(context, provider.addressData);
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
          flex: 3,
          child: TextField(
            decoration: InputDecoration(),
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
