import 'package:e_commerce_app/common_widgets/custom_button.dart';
import 'package:e_commerce_app/common_widgets/product_widget.dart';
import 'package:e_commerce_app/constant_key/detail_page.dart';
import 'package:e_commerce_app/data/model/product_model.dart';
import 'package:e_commerce_app/presentations/detail_page/detail_page_screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../cart_page/cart_check_out_screen_argument.dart';
import 'detail_page_provider.dart';

class DetailPageScreen extends StatelessWidget {
  const DetailPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailPageScreenArgument;
    List<ProductsModel> tmpList = [];
    tmpList.addAll(args.productList
        .where((element) => element.productId != args.productID));
    return ChangeNotifierProvider(
      create: (context) =>
          DetailPageProvider()..initalData(cartList: args.cartList),
      child: Consumer<DetailPageProvider>(builder: (context, data, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text("${args.productName}'s Details"),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context, data.cart);
                    },
                  )),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: PageView.builder(
                        itemCount: args.productImage.length,
                        itemBuilder: (context, index) {
                          return Image(
                            key: Key(DetailPageConstantKey.mainProductImageKey +
                                index.toString()),
                            fit: BoxFit.cover,
                            image:
                                Image.network(args.productImage[index]).image,
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                args.productName,
                                style: GoogleFonts.ibarraRealNova(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                "${args.price} AUD",
                                style: GoogleFonts.ibarraRealNova(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Description",
                            style: GoogleFonts.ibarraRealNova(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                              key: Key(DetailPageConstantKey.descriptionKey),
                              args.detail),
                          const SizedBox(height: 20),
                          Container(
                            key: Key(DetailPageConstantKey.categoryKey),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text(args.productCat),
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: tmpList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.7 / 2,
                                mainAxisSpacing: 20,
                              ),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return ProductWidget(
                                  key: Key(DetailPageConstantKey
                                          .otherProductImageKey +
                                      index.toString()),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                      context,
                                      '/detail_page',
                                      arguments: DetailPageScreenArgument(
                                        detail: tmpList[index].detail,
                                        productCat: tmpList[index].category,
                                        productID: tmpList[index].productId,
                                        productName: tmpList[index].productName,
                                        productImage:
                                            tmpList[index].productImage,
                                        price: tmpList[index].price,
                                        productList: args.productList,
                                        cartList: args.cartList,
                                      ),
                                    );
                                  },
                                  price: tmpList[index].price,
                                  productImage: tmpList[index].productImage[0],
                                  productName: tmpList[index].productName,
                                );
                              }),
                          const SizedBox(height: 60)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      color: Colors.grey.shade600,
                      onPressed: () async {
                        await data.writeJsonFile(
                          category: args.productCat,
                          price: args.price,
                          productId: args.productID,
                          productName: args.productName,
                          productImage: args.productImage[0],
                          amount: 1,
                        );
                      },
                      textTitle: "Add To Cart",
                      prefixIcon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      key: Key(DetailPageConstantKey.buyButtonKey),
                      color: Colors.grey.shade400,
                      onPressed: () async {
                        await data.writeJsonFile(
                          category: args.productCat,
                          price: args.price,
                          productId: args.productID,
                          productName: args.productName,
                          productImage: args.productImage[0],
                          amount: 1,
                        );
                        await Navigator.pushNamed(context, "/cart_page",
                            arguments: CartCheckOutScreenArguments(
                                cartList: data.cart));
                      },
                      textTitle: "Buy Now ",
                      textColor: Colors.white,
                      prefixIcon: const Icon(Icons.shopify_outlined,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
