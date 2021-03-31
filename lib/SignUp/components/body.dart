import 'package:flutter/material.dart';
import 'package:mystore/components/got_account_text.dart';

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
              SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              Text("SIGN UP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                    height: 1.5,
                  )),
              Spacer(),
              Align(alignment: Alignment.center, child: SignUpForm()),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Align(alignment: Alignment.center, child: GotAccountText()),
              SizedBox(height: 15),
            ],
          ),
        ));
  }
}
