import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.color = Colors.white,
    this.borderRadius = 0.0,
    required this.onPressed,
    this.textTitle,
    this.textColor = Colors.black,
    this.prefixIcon,
    this.widget,
  }) : super(key: key);
  final Color color;
  final Color textColor;
  final double borderRadius;
  final Function onPressed;
  final String? textTitle;
  final Icon? prefixIcon;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(10),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      onPressed: () => onPressed.call(),
      child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget ?? Container(),
              prefixIcon ?? Container(),
              textTitle == null
                  ? Container()
                  : Text(textTitle ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                      )),
            ],
          )),
    );
  }
}
