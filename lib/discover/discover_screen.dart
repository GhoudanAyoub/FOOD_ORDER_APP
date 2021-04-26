import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Inbox/components/conversation.dart';
import 'package:mystore/SignIn/sign_in_screen.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/profile/components/body.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  User user;
  TextEditingController searchController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];
  List<DocumentSnapshot> filteredUsers = [];
  bool loading = true;

  currentUserId() {
    return firebaseAuth.currentUser.uid;
  }

  getUsers() async {
    QuerySnapshot snap = await usersRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    users = doc;
    filteredUsers = doc;
    setState(() {
      loading = false;
    });
  }

  search(String query) {
    if (query == "") {
      filteredUsers = users;
    } else {
      List userSearch = users.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['username'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredUsers = userSearch;
      });
    }
  }

  removeFromList(index) {
    filteredUsers.removeAt(index);
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getAllUsers();
  }

  Widget getAllUsers() {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: const FractionalOffset(0.3, 0.4),
                end: const FractionalOffset(0.5, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 15.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(50.0),
                      child: TextFormField(
                          cursorColor: black,
                          controller: searchController,
                          onChanged: (query) {
                            search(query);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search,
                                  color: GBottomNav, size: 30.0),
                              contentPadding:
                                  EdgeInsets.only(left: 15.0, top: 15.0),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SFProDisplay-Black'))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Search Results',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                    child: Text('Users',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: buildUsers())
                ],
              )),
        ),
      ));
    });
  }

  buildUsers() {
    if (!loading) {
      if (filteredUsers.isEmpty) {
        return Center(
          child: Text("No User Found",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
      } else {
        return ListView.builder(
          itemCount: filteredUsers.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = filteredUsers[index];
            UserModel user = UserModel.fromJson(doc.data());
            if (firebaseAuth.currentUser != null && doc.id == currentUserId()) {
              checkIfFollowing(user.id);
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  removeFromList(index);
                });
              });
            }
            return Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(user.photoUrl != null &&
                              user.photoUrl != ""
                          ? user.photoUrl
                          : "https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                    ),
                    title: Text(user?.username,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    trailing: user.msgToAll == true
                        ? GestureDetector(
                            onTap: () {
                              firebaseAuth.currentUser == null
                                  ? SignInForMessage(context)
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Conversation(
                                          userId: doc.id,
                                          chatId: 'newChat',
                                        ),
                                      ));
                            },
                            child: Icon(CupertinoIcons.chat_bubble_fill,
                                color: Colors.redAccent),
                          )
                        : Container(
                            width: 1,
                          ),
                  ),
                ],
              ),
            );
          },
        );
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  SignInForMessage(BuildContext parentContext) {
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
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                child: Text(
                  'Sign In',
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

  showProfile(BuildContext context, {String profileId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Body(profileId: profileId),
        ));
  }

  checkIfFollowing(profileId) async {
    DocumentSnapshot doc = await followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
