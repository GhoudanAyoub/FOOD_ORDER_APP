import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/firebaseService/FirebaseService.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:rxdart/rxdart.dart';

import '../home.dart';
import 'menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  UserModel user1;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red[600],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      firebaseAuth.currentUser != null
                          ? FutureBuilder(
                              future: usersRef
                                  .doc(firebaseAuth.currentUser.uid)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  UserModel user =
                                      UserModel.fromJson(snapshot.data.data());
                                  print(firebaseAuth.currentUser.photoURL);
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(firebaseAuth
                                              .currentUser.photoURL ??
                                          FirebaseService().getProfileImage()),
                                    ),
                                    title: Text(
                                      user.username ?? 'X',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Lato-Bold.ttf',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      user.email ??
                                          firebaseAuth.currentUser.email,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Lato-Thin.ttf',
                                      ),
                                    ),
                                  );
                                }
                                return Text("loading");
                              },
                            )
                          : Container(
                              height: 10,
                            ),
                      Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: CupertinoIcons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: CupertinoIcons.shopping_cart,
                        title: "Shops",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: CupertinoIcons.archivebox,
                        title: "Categories",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      firebaseAuth.currentUser != null
                          ? StreamBuilder(
                              stream: usersRef
                                  .doc(firebaseAuth.currentUser.uid)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  user1 =
                                      UserModel.fromJson(snapshot.data.data());
                                  if (user1.msgToAll == true) {}
                                  return Column(
                                    children: [
                                      MenuItem(
                                        icon: CupertinoIcons.chart_bar_circle,
                                        title: "Dashboard",
                                        onTap: () {
                                          onIconPressed();
                                          BlocProvider.of<NavigationBloc>(
                                                  context)
                                              .add(NavigationEvents
                                                  .DashboardClickedEvent);
                                        },
                                      ),
                                      MenuItem(
                                        icon: CupertinoIcons.bag,
                                        title: "Manage Shops",
                                        onTap: () {
                                          onIconPressed();
                                          BlocProvider.of<NavigationBloc>(
                                                  context)
                                              .add(NavigationEvents
                                                  .ShopClickedEvent);
                                        },
                                      ),
                                      MenuItem(
                                        icon: Icons.add_circle_outline,
                                        title: "Add Products",
                                        onTap: () {
                                          onIconPressed();
                                          BlocProvider.of<NavigationBloc>(
                                                  context)
                                              .add(NavigationEvents
                                                  .AddProductClickedEvent);
                                        },
                                      ),
                                      MenuItem(
                                        icon: Icons
                                            .supervised_user_circle_outlined,
                                        title: "Manage Customers",
                                        onTap: () {
                                          onIconPressed();
                                          BlocProvider.of<NavigationBloc>(
                                                  context)
                                              .add(NavigationEvents
                                                  .CustomersClickedEvent);
                                        },
                                      ),
                                    ],
                                  );
                                }
                                return Container(
                                  height: 0,
                                );
                              },
                            )
                          : Container(
                              height: 10,
                            ),
                      Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: CupertinoIcons.settings,
                        title: "Settings",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      firebaseAuth.currentUser != null
                          ? MenuItem(
                              icon: Icons.exit_to_app,
                              title: "Logout",
                              onTap: () {
                                logOut(context);
                              },
                            )
                          : Container(
                              height: 10,
                            ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.95),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 80,
                      color: Colors.red[600],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  logOut(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.red[800],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  FirebaseService().signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
