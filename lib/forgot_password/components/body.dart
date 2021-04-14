import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/firebaseService/FirebaseService.dart';
import 'package:mystore/utils/validation.dart';

import '../../SizeConfig.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.grey.withOpacity(0),
              ]),
          image: DecorationImage(
            image: ExactAssetImage('assets/images/pg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.40),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Lato-Bold.ttf',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Please enter your email and we will send \nyou a link to return to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Lato-Thin.ttf',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  ForgotPassForm(),
                ],
              ),
            ),
          ),
        ));
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailContoller = TextEditingController();
  var submitted = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildEmailFormField(),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: getProportionateScreenWidth(100),
            height: 45,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.orange,
              disabledColor: Colors.grey[400],
              disabledTextColor: Colors.white60,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  submitted = true;
                  final auth = FirebaseService();
                  auth.sendPasswordResetEmail(_emailContoller.text);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'A password reset link has been sent to ${_emailContoller.text}')));
                }
              },
              child: submitted
                  ? SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato-Regular.ttf',
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  buildEmailFormField() {
    return TextFormBuilder(
      prefix: Feather.mail,
      controller: _emailContoller,
      hintText: "Email",
      textInputAction: TextInputAction.next,
      validateFunction: Validations.validateEmail,
    );
  }
}
