import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/utils/firebase.dart';

import '../SizeConfig.dart';

class Customers extends StatefulWidget with NavigationStates {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  User user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];
  List<DocumentSnapshot> filteredUsers = [];
  bool loading = true;
  bool isFollowing = false;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            Image.asset('assets/images/pl.png', width: 100, height: 100),
          ],
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.red[900],
                  Colors.grey.withOpacity(0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Container(
                      height: 530.0,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: SizeConfig.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.color_filter,
                                color: Colors.red,
                                size: 40,
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                  child: buildUsers())
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 570, 10, 10),
                  child: Container(
                      height: 100.0,
                      child: Container(
                        width: SizeConfig.screenWidth,
                        child: Text(
                            "Click on Customers name to See \nmore details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins')),
                      )),
                ),
              ],
            ),
          ),
        ));
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
            return Column(
              children: [
                ListTile(
                  // onTap: () => showProfile(context, profileId: user?.id),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  title: Text(user?.username,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  /* trailing: user.msgToAll == true || isFollowing == true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Conversation(
                                    userId: doc.id,
                                    chatId: 'newChat',
                                  ),
                                ));
                          },
                          child: Icon(CupertinoIcons.chat_bubble_fill,
                              color: Colors.black),
                        )
                      : Container(
                          width: 1,
                        ),*/
                ),
                Divider(),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(children: [
                      Text('Cell 1',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Cell 2',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Cell 3',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ],
                ),
              ],
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
}
