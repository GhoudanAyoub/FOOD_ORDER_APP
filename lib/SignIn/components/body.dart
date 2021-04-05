import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: SizeConfig.screenHeight,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.35),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.2),
                    Container(
                      child: Column(
                        children: [
                          NoAccountText(),
                          SizedBox(height: 20),
                          Text(
                            "Or Signup using",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocalCard(
                                icon: "assets/icons/facebook-2.svg",
                                Name: "Facebook",
                                press: () {
                                  handleLogin(context);
                                },
                              ),
                              SocalCard(
                                icon: "assets/icons/google-icon.svg",
                                Name: "Gmail",
                                press: () async {
                                  await signInWithGoogle(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  /*
  *
  *
  *Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black45,
                  Colors.grey.withOpacity(0.2),
                ]),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(alignment: Alignment(0, 20), child: SignForm()),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          NoAccountText(),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Text(
                            "Or Signup using",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocalCard(
                                icon: "assets/icons/google-icon.svg",
                                press: () async {
                                  await signInWithGoogle(context);
                                },
                              ),
                              SocalCard(
                                icon: "assets/icons/facebook-2.svg",
                                press: () {
                                  handleLogin(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ))
          *
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black45.withOpacity(1),
                      Colors.black45.withOpacity(0.2),
                    ])),
              ),
            ),
  * */
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
    Navigator.pushNamed(context, HomeScreen.routeName);
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
