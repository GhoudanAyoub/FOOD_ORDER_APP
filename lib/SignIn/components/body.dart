import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mystore/components/custom_card.dart';
import 'package:mystore/components/no_account_text.dart';
import 'package:mystore/components/socal_card.dart';
import 'package:mystore/firebaseService/FirebaseService.dart';
import 'package:mystore/home/home_screen.dart';

import '../../SizeConfig.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  bool isSignIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
          child: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30)),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.35),
                        SignForm(),
                        SizedBox(height: 40),
                        NoAccountText(),
                        SizedBox(height: 20),
                        Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 1,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              Divider(
                                indent: 5,
                                endIndent: 5,
                              ),
                              Text(
                                "OR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              Divider(
                                indent: 5,
                                endIndent: 5,
                              ),
                              SizedBox(
                                width: 150,
                                height: 1,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                  elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.blue[900],
                                  child: GestureDetector(
                                    onTap: () {
                                      handleLogin(context);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      height: 40,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/fb.svg",
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Join with facebook",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Lato-Bold.ttf',
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              CustomCard(
                                borderRadius: BorderRadius.circular(20.0),
                                child: SocalCard(
                                  icon: "assets/icons/google-icon.svg",
                                  Name: "Join with Google",
                                  press: () async {
                                    await signInWithGoogle(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )),
    );
  }

  Future<void> signInWithGoogle(context) async {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Checking Your Account..")));
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("please Wait..")));
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    UserCredential userdata =
        await _firebaseAuth.signInWithCredential(credential).catchError((e) {
      print("Error===>" + e.toString());
    });
    FirebaseService.addUsers(userdata.user);
    Navigator.pop(context);
    //Navigator.pushNamed(context, HomeScreen.routeName);
  }

  Future<void> handleLogin(context) async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print(result.errorMessage);
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          await loginWithfacebook(result, context);
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  Future loginWithfacebook(FacebookLoginResult result, context) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
        FacebookAuthProvider.credential(accessToken.token);
    await _auth.signInWithCredential(credential).catchError((e) {
      print(e.toString());
    }).then((value) => () {
          FirebaseService.addUsers(value.user);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
    isSignIn = true;
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
