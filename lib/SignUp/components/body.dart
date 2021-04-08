import 'package:flutter/material.dart';

import '../../SizeConfig.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text("SIGN UP",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato-Bold.ttf',
                      color: Colors.red[900],
                    )),
              ),
              SizedBox(height: 80),
              Align(alignment: Alignment.center, child: SignUpForm()),
              /* Align(alignment: Alignment.center, child: GotAccountText()),*/
            ],
          ),
        ));
  }
}
