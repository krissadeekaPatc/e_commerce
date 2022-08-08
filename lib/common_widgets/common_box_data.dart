import 'package:flutter/material.dart';

class CommonBoxData extends StatelessWidget {
  CommonBoxData({Key? key, required this.widget}) : super(key: key);
  Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          bottom: 20,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: widget);
  }
}
