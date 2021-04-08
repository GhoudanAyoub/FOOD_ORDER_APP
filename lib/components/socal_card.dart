import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../SizeConfig.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({Key key, this.icon, this.press, this.Name})
      : super(key: key);

  final String icon;
  final String Name;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(50),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              Name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato-Bold.ttf',
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
