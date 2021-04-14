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
  List<UserModel> _list = [];
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
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                    height: 600.0,
                    child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: SizeConfig.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.color_filter,
                                color: Colors.red,
                                size: 30,
                              ),
                              buildUsers()
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 650, 10, 10),
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
        ));
  }

  getUsers() async {
    QuerySnapshot snap = await usersRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    users = doc;
    filteredUsers = doc;

    for (var fl in filteredUsers) {
      DocumentSnapshot doc1 = fl;
      _list.add(UserModel.fromJson(doc1.data()));
    }
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
          itemCount: 1,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return DataTable(
              columns: [
                DataColumn(
                    label: Text('Customers',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    tooltip: 'represents name of the user'),
                DataColumn(
                    label: Text('Subscribed',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    tooltip: 'represents is the user is  subscribed'),
                DataColumn(
                    label: Text('Oders',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    tooltip:
                        'represents the number of orders that users makes'),
              ],
              rows: _list
                  .map((data) => DataRow(cells: [
                        DataCell(
                            Text(data.username,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.normal)), onTap: () {
                          print(data.username);
                        }),
                        DataCell(Text(data.sub == true ? "Yes" : "No",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal))),
                        DataCell(Text(data.orders.toString(),
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal))),
                      ]))
                  .toList(),
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
