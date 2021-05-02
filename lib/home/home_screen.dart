import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Notification/notification.dart';
import 'package:mystore/SignIn/sign_in_screen.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/discover/discover_screen.dart';
import 'package:mystore/firebaseService/FirebaseService.dart';
import 'package:mystore/profile/profile_screen.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import 'Conposante/body.dart';

class HomeScreen extends StatefulWidget with NavigationStates {
  static String routeName = "/home";
  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseService.changeStatus("Online");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new WillPopScope(
        onWillPop: () async => false,
        child: getBody(),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: pageIndex,
        showElevation: true,
        backgroundColor: kTextColor1,
        itemCornerRadius: 24,
        curve: Curves.easeInCubic,
        onItemSelected: (index) => setState(() => pageIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages',
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text('Profile'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        Body(),
        DiscoverScreen(),
        firebaseAuth.currentUser == null ? SignInForMessage() : Activities(),
        firebaseAuth.currentUser == null
            ? SignInForProfile()
            : ProfileScreen(
                profileUID: firebaseAuth.currentUser.uid,
              ),
      ],
    );
  }

  Widget SignInForProfile() {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Center(
            child: Text("Profile",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.person,
                  color: Colors.grey,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up For An Account",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.redAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato-Regular.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget SignInForMessage() {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Center(
          child: Text("Message",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.mail,
                color: Colors.grey,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Message Will appear here",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato-Regular.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void dispose() async {
    FirebaseService.changeStatus("Away");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    FirebaseService.changeStatus("Away");
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
