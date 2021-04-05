import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/default_button.dart';
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
            image: ExactAssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.35),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Please enter your email and we will send \nyou a link to return to your account",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
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
          DefaultButton(
            text: "Reset",
            submitted: submitted,
            press: () {
              if (_formKey.currentState.validate()) {
                submitted = true;
                final auth = FirebaseService();
                auth.sendPasswordResetEmail(_emailContoller.text);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'A password reset link has been sent to ${_emailContoller.text}')));
              }
            },
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
