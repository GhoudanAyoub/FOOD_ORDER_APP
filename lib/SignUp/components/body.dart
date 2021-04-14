import 'package:flutter/material.dart';

import '../../SizeConfig.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/pg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: SizeConfig.screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
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
                    SignUpForm()
                    /* Align(alignment: Alignment.center, child: GotAccountText()),*/
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
