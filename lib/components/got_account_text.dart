import 'package:flutter/material.dart';
import 'package:mystore/SignIn/sign_in_screen.dart';

class GotAccountText extends StatelessWidget {
  GotAccountText({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: Text(
            "Sign In Using",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
