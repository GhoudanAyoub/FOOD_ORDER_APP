import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/form_error.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/forgot_password/forgot_password_screen.dart';
import 'package:mystore/helper/keyboard.dart';
import 'package:mystore/home/home.dart';
import 'package:mystore/services/auth_service.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:mystore/utils/validation.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool remember = false;
  final List<String> errors = [];

  var submitted = false;
  var buttonText = "LOGIN";

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

  buildPasswordFormField() {
    return TextFormBuilder(
      prefix: Feather.lock,
      controller: _passwordController,
      obscureText: true,
      hintText: "Password",
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildEmailFormField(),
          SizedBox(height: 5),
          buildPasswordFormField(),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato-Thin.ttf',
                      color: Colors.white),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
            child: DefaultButton(
              text: buttonText,
              submitted: submitted,
              press: () async {
                AuthService auth = AuthService();
                if (_formKey.currentState.validate()) {
                  submitted = true;
                  KeyboardUtil.hideKeyboard(context);
                  String success;
                  try {
                    removeError(error: success);
                    success = await auth.loginUser(
                      email: _emailContoller.text,
                      password: _passwordController.text,
                    );
                    print(success);
                    if (success == firebaseAuth.currentUser.uid) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Welcome Back')));
                    } else {
                      addError(error: success);
                      submitted = false;
                    }
                  } catch (e) {
                    submitted = false;
                    print("=====" + success);
                    addError(error: success);
                    showInSnackBar(
                        '${auth.handleFirebaseAuthError(e.toString())}');
                  }
                }
              },
            ),
          ),
          FormError(errors: errors),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
