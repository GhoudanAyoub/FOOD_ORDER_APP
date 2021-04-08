import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';

import '../SizeConfig.dart';

class Shop extends StatefulWidget with NavigationStates {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  /*
  Shops shop;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> shop = [];
  List<DocumentSnapshot> filteredShops = [];
  List<ShopModel> _list = [];
  bool loading = true;
  bool isFollowing = false;

  @override
  void initState() {
    getShops();
    super.initState();
  }*/
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
/*
  getShops() async {
    QuerySnapshot snap = await shopRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    shops = doc;
    filteredShps = doc;
    setState(() {
      loading = false;
    });
  }

  buildShops() {
    if (!loading) {
      if (filteredShps.isEmpty) {
        return Center(
          child: Text("No User Found",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
      } else {
        return ListView.builder(
          itemCount: filteredShps.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = filteredShps[index];
            ShopsModel user = ShopsModel.fromJson(doc.data());
            _list.add(user);
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
                DataCell(Text("Sub",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.normal))),
                DataCell(Text("orders",
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
  }*/

}
