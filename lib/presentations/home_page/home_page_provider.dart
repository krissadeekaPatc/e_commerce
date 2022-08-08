import 'dart:convert';
import 'dart:math';
import 'package:e_commerce_app/data/model/cart_check_out.dart';
import 'package:e_commerce_app/data/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageProvider with ChangeNotifier {
  List<ProductsModel> productsData = [];
  List<ProductsModel> filteredData = [];
  List<CartModel> cartData = [];
  bool isFilter = false;
  List mockUpData = [];
  int selectedIndex = 0;

  List category = ["ALL", "T-SHIRT", "PANTS", "JEANS", "GLOVES", "SNEAKER"];
  mockingUpData() {
    Random random = Random();

    mockUpData = [
      {
        "productName": "Kra pow 1",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "category": "T-SHIRT",
        "productImage": [
          "https://images.unsplash.com/photo-1627913363993-95b23378265e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80",
          "https://as2.ftcdn.net/v2/jpg/02/95/25/29/1000_F_295252997_22SEDs8RHlz8yxl1geqxo85ofwpMOwgH.jpg"
        ]
      },
      {
        "category": "T-SHIRT",
        "productName": "Kra pow 2",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/02/95/25/29/1000_F_295252997_22SEDs8RHlz8yxl1geqxo85ofwpMOwgH.jpg"
        ]
      },
      {
        "category": "T-SHIRT",
        "productName": "Kra pow 3",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/02/83/77/11/1000_F_283771109_tN80IWhT7OaFfJYYUVwYWD5yd8MIMTx5.jpg"
        ]
      },
      {
        "category": "T-SHIRT",
        "productName": "Kra pow 4",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/04/80/98/76/1000_F_480987683_rpgU2klOwCnaFGq5UY7TFXl2tx9ZS9rI.jpg"
        ]
      },
      {
        "category": "T-SHIRT",
        "productName": "Kra pow 5",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/02/56/87/67/1000_F_256876731_a76IKBVDSkgPHfCJAhAi3pCoMl3zU94u.jpg"
        ]
      },
      {
        "category": "PANTS",
        "productName": "Kra pow 6",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/03/12/17/10/1000_F_312171037_5f7JzRNHExVMcHPFSnYnmiZkrNh0wcir.jpg"
        ]
      },
      {
        "category": "PANTS",
        "productName": "Kra pow 7",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/03/12/17/10/1000_F_312171078_bDUr9shuZqyJEl6CNfcTeoF84UUvTUIu.jpg"
        ]
      },
      {
        "category": "PANTS",
        "productName": "Kra pow 8",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/02/35/72/66/1000_F_235726613_UOorneLjoWd5qlDqujI64Ub2zKwR0WXK.jpg"
        ]
      },
      {
        "category": "PANTS",
        "productName": "Kra pow 9",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/02/89/87/19/1000_F_289871921_8OU0GHselTxaFczzV4SlJFXKAuWnFYsE.jpg"
        ]
      },
      {
        "category": "PANTS",
        "productName": "Kra pow 10",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/03/93/00/57/1000_F_393005713_bZc0Cj4t4AAhtXPAnMJTH6e5VphC5ZuW.jpg"
        ]
      },
      {
        "category": "GLOVES",
        "productName": "Kra pow 6",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/02/97/66/99/1000_F_297669995_BB4qSTaelQpFLUovwKsDMJt6sqtTAQyB.jpg"
        ]
      },
      {
        "category": "GLOVES",
        "productName": "Kra pow 7",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/02/35/47/56/1000_F_235475635_I55kOdd7mriN1R9BE50CvTuv3v87X9Hg.jpg"
        ]
      },
      {
        "category": "GLOVES",
        "productName": "Kra pow 8",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/00/18/75/74/1000_F_18757448_UoB3J8osqd2NMR2rgL7hQEIcx0bC9BxU.jpg"
        ]
      },
      {
        "category": "GLOVES",
        "productName": "Kra pow 9",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/03/14/70/62/1000_F_314706289_gjtJH7T6lNjQyRqW4nvV6al7U8CGkkgH.jpg"
        ]
      },
      {
        "category": "GLOVES",
        "productName": "Kra pow 10",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/02/96/26/52/1000_F_296265260_Dvd0oonBVElIOSofmoNBB6wwoV4CwOHz.jpg"
        ]
      },
      {
        "category": "JEANS",
        "productName": "Kra pow 6",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/05/03/06/76/1000_F_503067645_hYZR5siGcxdNLnwHDoKrrrbAZVW6hZTD.jpg"
        ]
      },
      {
        "category": "JEANS",
        "productName": "Kra pow 7",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/00/78/74/61/1000_F_78746111_9ohwxia2rgPaEPoK9sZug6nFW1PCBRPB.jpg"
        ]
      },
      {
        "category": "JEANS",
        "productName": "Kra pow 8",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/04/69/03/48/1000_F_469034824_SXv2w53tC1HAXIg5VyXnRvv1VERCgxqo.jpg"
        ]
      },
      {
        "category": "JEANS",
        "productName": "Kra pow 9",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as2.ftcdn.net/v2/jpg/03/01/63/41/1000_F_301634178_ztuyniETGYlpGsWTh1gFnSPa2zWmp1Xf.jpg"
        ]
      },
      {
        "category": "JEANS",
        "productName": "Kra pow 10",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://as1.ftcdn.net/v2/jpg/00/78/69/46/1000_F_78694664_qaFdsPYx0wTlkJPl5fSkdkB8KEvmeuoL.jpg"
        ]
      },
      {
        "category": "SNEAKER",
        "productName": "Kra pow 1",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://images.unsplash.com/photo-1561808843-7adeb9606939?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80"
        ]
      },
      {
        "category": "SNEAKER",
        "productName": "Kra pow 2",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://images.unsplash.com/photo-1608667508764-33cf0726b13a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80"
        ]
      },
      {
        "category": "SNEAKER",
        "productName": "Kra pow 3",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80"
        ]
      },
      {
        "category": "SNEAKER",
        "productName": "Kra pow 4",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://images.unsplash.com/photo-1608666634759-4376010f863d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80"
        ]
      },
      {
        "category": "SNEAKER",
        "productName": "Kra pow 5",
        "productId": generateUID(10),
        "price": random.nextInt(300),
        "detail":
            "The lone lamp post of the one-street town flickered, not quite dead but definitely on its way out. Suitcase by her side, she paid no heed to the light, the street or the town. A car was coming down the street and with her arm outstretched and thumb in the air, she had a plan.",
        "productImage": [
          "https://images.unsplash.com/photo-1605034313761-73ea4a0cfbf3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80"
        ]
      }
    ];
    notifyListeners();
  }

  String generateUID(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return "${randomString}${_random.nextInt(9999)} ";
  }

  initialData(bool isComplete) async {
    mockingUpData();

    filteredData.clear();
    productsData.clear();

    mockUpData.forEach((element) {
      productsData.add(
        ProductsModel(
          productImage: element['productImage'],
          category: element["category"],
          detail: element["detail"],
          productName: element["productName"],
          productId: element["productId"],
          price: element['price'],
        ),
      );
    });
    filteredData.addAll(productsData);

    if (isComplete) {
      cartData.clear();
    } else {
      cartData = await readJsonFile();
    }
    notifyListeners();
  }

  Future<List<CartModel>> readJsonFile() async {
    final String response =
        await rootBundle.loadString("assets/data/cart_data.json");
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  filterList(String category) {
    filteredData.clear();
    if (category == "ALL") {
      filteredData.addAll(productsData);
    }
    filteredData
        .addAll(productsData.where((element) => element.category == category));
    notifyListeners();
  }

  setValue(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  addedNewProduct(List<CartModel> cartData) {
    this.cartData = cartData;
    notifyListeners();
  }
}
