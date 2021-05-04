import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/utils/firebase.dart';

import '../Admin/Components/custom_app_bar.dart';
import '../Admin/Components/stats_grid.dart';
import '../SizeConfig.dart';

class AdminBord extends StatefulWidget with NavigationStates {
  @override
  _AdminBordState createState() => _AdminBordState();
}

class _AdminBordState extends State<AdminBord> {
  User user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];
  List<DocumentSnapshot> filteredUsers = [];
  List<UserModel> _list = [];
  bool loading = true;
  bool isFollowing = false;
  String dropdownValue = 'Month';
  final covidUSADailyNewCases = [
    12.17,
    11.15,
    10.02,
    11.21,
    13.83,
    14.16,
    14.30
  ];
  Map<String, double> dataMap = {
    'Daily Total': 680,
    'Completed Orders ': 330,
    'New Registrations': 200
  };
  List<Color> colorList = [
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.blueAccent
  ];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 5, 5),
          child: Stack(
            children: [
              Positioned(
                top: 100.0,
                left: 100.0,
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    "assets/images/coffee2.png",
                    width: 150.0,
                  ),
                ),
              ),
              Positioned(
                top: 120.0,
                right: -180.0,
                child: Image.asset(
                  "assets/images/square.png",
                ),
              ),
              Positioned(
                child: Image.asset(
                  "assets/images/drum.png",
                ),
                left: -70.0,
                bottom: -40.0,
              ),
              CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  /* SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(covidCases: covidUSADailyNewCases),
            ),
          ),*/
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: SliverToBoxAdapter(
                      child: StatsGrid(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                          height: 300.0,
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                width: SizeConfig.screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Top Sellers',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        DropdownButton<String>(
                                            value:
                                                dropdownValue ?? dropdownValue,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 32,
                                            underline: SizedBox(),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Month',
                                              'Daily',
                                              'Year',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList()),
                                      ],
                                    ),
                                    buildUsers()
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
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
        return Container(
          child: ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return DataTable(
                columns: [
                  DataColumn(
                      label: Text('Customers',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      tooltip: 'represents name of the user'),
                  DataColumn(
                      label: Text('Oders',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      tooltip:
                          'represents the number of orders that users makes'),
                  DataColumn(
                      label: Text('Option',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      tooltip:
                          'represents the number of orders that users makes'),
                ],
                rows: _list
                    .map((data) => DataRow(cells: [
                          DataCell(
                              Text(data.username,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.normal)),
                              onTap: () {
                            print(data.username);
                          }),
                          DataCell(Text(data.orders.toString(),
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
          ),
        );
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }
}
