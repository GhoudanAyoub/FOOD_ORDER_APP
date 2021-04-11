import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/form_error.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/home/home.dart';
import 'package:mystore/services/auth_service.dart';
import 'package:mystore/utils/validation.dart';

import '../../SizeConfig.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var submitted = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _namentoller = TextEditingController();
  TextEditingController _countryContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String email;
  String password;
  String conform_password;
  bool remember = false;
  AuthService authService = AuthService();
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
        submitted = false;
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildENameFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildConformPassFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildECountryFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildPhoneFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(15)),
            DefaultButton(
              text: "SIGN UP",
              submitted: submitted,
              press: () async {
                try {
                  if (_formKey.currentState.validate()) {
                    submitted = true;
                    bool success = await authService.createUser(
                        name: _namentoller.text,
                        email: _emailContoller.text,
                        password: _passwordController.text,
                        country: _countryContoller.text,
                        phone: _phone.text);
                    print(success);
                    if (success) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Congratulation Your Account Created')));
                    }
                  }
                } catch (e) {
                  print(e);
                  showInSnackBar(
                      '${authService.handleFirebaseAuthError(e.toString())}');
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void emailExists() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey[800],
              ),
              height: 190,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'This Email is on Another Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            "You can log into the account associated with that email.",
                            style: TextStyle(color: Colors.white60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/HomeScreen'));
                      },
                      child: Text(
                        'Log in to Existing Account',
                        style: TextStyle(color: Colors.lightBlue[400]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  buildPasswordFormField() {
    return TextFormBuilder(
      prefix: Feather.lock,
      controller: _passwordController,
      obscureText: true,
      hintText: "Create a Password",
      textInputAction: TextInputAction.next,
      validateFunction: Validations.validatePassword,
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

  buildConformPassFormField() {
    return TextFormBuilder(
      prefix: Feather.lock,
      controller: _passwordController2,
      obscureText: true,
      hintText: "Re-type Password",
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => conform_password = newValue,
    );
  }

  buildENameFormField() {
    return TextFormBuilder(
      prefix: Feather.info,
      controller: _namentoller,
      hintText: "Name",
      textInputAction: TextInputAction.next,
    );
  }

  buildECountryFormField() {
    return TextFormBuilder(
      prefix: Feather.map,
      controller: _countryContoller,
      hintText: "Address",
      textInputAction: TextInputAction.next,
    );
  }

  buildPhoneFormField() {
    return TextFormBuilder(
      prefix: Feather.phone,
      controller: _phone,
      hintText: "Phone number",
      textInputAction: TextInputAction.next,
    );
  }
}
