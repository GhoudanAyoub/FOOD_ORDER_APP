import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Notification/notification.dart';
import 'package:mystore/discover/discover_screen.dart';
import 'package:mystore/firebaseService/FirebaseService.dart';
import 'package:mystore/profile/profile_screen.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Conposante/body.dart';

class HomeScreen extends StatefulWidget {
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
        backgroundColor: Colors.red[800],
        itemCornerRadius: 24,
        curve: Curves.easeIn,
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
        Activities(),
        ProfileScreen(
          profileUID: firebaseAuth.currentUser.uid,
        ),
      ],
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
