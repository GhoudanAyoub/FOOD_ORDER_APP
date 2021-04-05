import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/default_button.dart';

import '../SizeConfig.dart';

class AdminBord extends StatefulWidget with NavigationStates {
  @override
  _AdminBordState createState() => _AdminBordState();
}

class _AdminBordState extends State<AdminBord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Image.asset('assets/images/pl.png', width: 100, height: 100),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                chooseUpload2(context);
              },
              iconSize: 21,
              icon: Icon(Icons.list),
            )
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
                  Colors.red[600],
                  Colors.grey.withOpacity(0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                      height: 180.0,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: SizeConfig.screenWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Daily Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Order Completion \nRate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "New \nRegistrations",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 200, 10, 10),
                  child: Container(
                      height: 350.0,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: SizeConfig.screenWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DefaultButton(
                              text: "View Report",
                              press: () {},
                              submitted: false,
                            ),
                            DefaultButton(
                              text: "Generate Report",
                              press: () {
                                Navigator.pop(context);
                              },
                              submitted: false,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  chooseUpload2(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.bottomCenter,
          width: 200,
          child: Container(
            height: 500,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.red[800],
                      endIndent: 200,
                      indent: 200,
                      thickness: 4,
                      height: 0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [clipsWidget2()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget clipsWidget2() {
    return Container(
      height: 400,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.HomePageClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.ShopClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Manage Shops",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.AddProductClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Add Products",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.CustomersClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Manage Customers",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            "Reports",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
