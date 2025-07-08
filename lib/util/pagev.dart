import 'package:flutter/material.dart';

class Pagev extends StatelessWidget {
  const Pagev({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEFEFEF),
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10),
          child: Image.network(
            "https://t4.ftcdn.net/jpg/05/89/90/83/360_F_589908398_6RaggcvYGDzFF0Oh2JAcepJHeU6XLJEZ.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
