import 'package:e_commerce_app/constant_key/home_page.dart';
import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:e_commerce_app/data/model/product_model.dart';
import 'package:e_commerce_app/presentations/cart_page/cart_check_out_screen.dart';
import 'package:e_commerce_app/presentations/cart_page/cart_check_out_screen_argument.dart';
import 'package:e_commerce_app/presentations/home_page/home_page_argument.dart';
import 'package:e_commerce_app/presentations/home_page/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/product_widget.dart';
import '../detail_page/detail_page_screen_argument.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as HomePageArgument?;
    return ChangeNotifierProvider(
      create: (context) =>
          HomePageProvider()..initialData(args?.isComplete ?? false),
      child: Consumer<HomePageProvider>(builder: (context, data, _) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.2,
              title: Column(
                children: [
                  Text(
                    "E - Commerce",
                    style: GoogleFonts.ibarraRealNova(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        key: Key(HomePageConstantKey.cartButtonKey),
                        onTap: () {
                          Navigator.pushNamed(context, "/cart_page",
                              arguments: CartCheckOutScreenArguments(
                                  cartList: data.cartData));
                        },
                        child: Stack(
                          alignment: const Alignment(2.4, -4),
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                  minHeight: 33, minWidth: 33),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      color: Colors.black.withAlpha(50))
                                ],
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red.shade500,
                              ),
                              child: Center(
                                child: Text("${data.cartData.length}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              backgroundColor: Colors.black87,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.category.length,
                      itemBuilder: (c, i) {
                        final cat = data.category[i];
                        return InkWell(
                          key: Key(HomePageConstantKey.filterButtonKey),
                          onTap: () {
                            data.setValue(i);
                            data.filterList(data.category[data.selectedIndex]);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                                color: data.selectedIndex == i
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(22)),
                            width: data.selectedIndex == i ? 150 : 100,
                            child: Center(
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: data.selectedIndex == i ? 22 : 18,
                                  color: data.selectedIndex == i
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.filteredData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7 / 2,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (c, i) {
                      return ProductWidget(
                        key: Key("${HomePageConstantKey.productListKey}$i"),
                        onPressed: () {
                          List<ProductsModel> tmpList = [];
                          tmpList.addAll(
                            data.filteredData.where(
                              (element) =>
                                  element.productId !=
                                  data.filteredData[i].productId,
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            '/detail_page',
                            arguments: DetailPageScreenArgument(
                              detail: data.filteredData[i].detail,
                              productCat: data.filteredData[i].category,
                              productID: data.filteredData[i].productId,
                              productName: data.filteredData[i].productName,
                              productImage: data.filteredData[i].productImage,
                              price: data.filteredData[i].price,
                              productList: data.filteredData,
                              cartList: data.cartData,
                            ),
                          ).then((value) {
                            data.initialData(false);
                            data.addedNewProduct(value as List<CartModel>);
                          });
                        },
                        price: data.filteredData[i].price,
                        productImage: data.filteredData[i].productImage[0],
                        productName: data.filteredData[i].productName,
                      );
                    }),
              ],
            )),
          ),
        );
      }),
    );
  }
}
