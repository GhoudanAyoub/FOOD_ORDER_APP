import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/SignUp/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato-Regular.ttf',
              color: Colors.white),
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Lato-Regular.ttf',
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
      ],
    );
  }
}
