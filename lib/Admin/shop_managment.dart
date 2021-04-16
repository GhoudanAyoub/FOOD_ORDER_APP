import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/shop.dart';
import 'package:mystore/utils/firebase.dart';

import '../SizeConfig.dart';
import 'add_store.dart';

class Shop extends StatefulWidget with NavigationStates {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  ShopModel shop;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> shoplist = [];
  List<DocumentSnapshot> filteredShops = [];
  List<ShopModel> _list = [];
  bool loading = true;
  bool isFollowing = false;

  @override
  void initState() {
    getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            Image.asset('assets/images/pl.png', width: 100, height: 100)
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.color_filter,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => AddStore(),
                                          ));
                                    },
                                    child: Icon(
                                      CupertinoIcons.add_circled,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              buildShops()
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
                        child: Text("Click on shop name to See \nmore details",
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

  getShops() async {
    QuerySnapshot snap = await shopRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    shoplist = doc;
    filteredShops = doc;

    for (var fl in filteredShops) {
      DocumentSnapshot doc1 = fl;
      _list.add(ShopModel.fromJson(doc1.data()));
    }
    setState(() {
      loading = false;
    });
  }

  buildShops() {
    if (!loading) {
      if (filteredShops.isEmpty) {
        return Center(
          child: Text("No Shop Found",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
      } else {
        return Flexible(
            child: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return DataTable(
              columns: [
                DataColumn(
                    label: Flexible(
                      child: Text('Registered Shops',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    tooltip: 'represents name of the Shops'),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    tooltip: 'represents is the Shops Status'),
                DataColumn(
                    label: Flexible(
                      child: Text('Oder Completion Rate',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    tooltip: 'represents the number of orders completed'),
              ],
              rows: _list
                  .map((data) => DataRow(cells: [
                        DataCell(
                            Text(data.name,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.normal)), onTap: () {
                          print(data.name);
                        }),
                        DataCell(Text(data.status == true ? "Active" : "Paused",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal))),
                        DataCell(Text(
                            "${CountRate(data) != null ? CountRate(data).toString() : 0}%",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal))),
                      ]))
                  .toList(),
            );
          },
        ));
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  double CountRate(ShopModel data) {
    if (data.completedOrders != null)
      double rate = (data.completedOrders.length * 100) / data.orders.length;
  }
}
