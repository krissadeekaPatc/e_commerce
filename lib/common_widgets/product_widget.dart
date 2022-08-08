import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.onPressed,
    required this.productImage,
    required this.productName,
    required this.price,
  }) : super(key: key);

  final Function onPressed;
  final String productImage;
  final String productName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image(
                    fit: BoxFit.cover,
                    image: Image.network(
                      productImage,
                    ).image),
              ),
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 12, left: 15, right: 15),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(productName),
                      Text(
                        "$price AUD",
                        style: GoogleFonts.ibarraRealNova(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
