import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/utils/firebase.dart';

import 'lmaida_card.dart';

class Body extends StatefulWidget with NavigationStates {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserModel user1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          StreamBuilder(
            stream: usersRef.doc(firebaseAuth.currentUser.uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                user1 = UserModel.fromJson(snapshot.data.data());
                if (user1.msgToAll == true) {}
                return IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    chooseUpload2(context);
                  },
                  iconSize: 21,
                  icon: Icon(Icons.list),
                );
              }
              return IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  chooseUpload(context);
                },
                iconSize: 21,
                icon: Icon(Icons.list),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          deals1('', onViewMore: () {}, items: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                child: LmaidaCard(
                  onTap: () => {},
                  imagePath:
                      'https://static3.depositphotos.com/1003631/209/i/950/depositphotos_2099183-stock-photo-fine-table-setting-in-gourmet.jpg', //'imagePaths[index]',
                ),
              ),
            ),
          ]),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            height: 40.0,
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.  \nstandard dummy text ever since the 15",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins')),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      chooseUpload(context);
                    },
                    iconSize: 21,
                    icon: Icon(Icons.list),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Center(
              child: Text("Categories",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins')),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Center(
              child: Text("Recently Searched",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins')),
            ),
          ),
        ],
      ),
    );
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
                  .add(NavigationEvents.DashboardClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Dashboard",
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

  chooseUpload(BuildContext context) {
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
            height: 2 * MediaQuery.of(context).size.height / 3,
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
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [clipsWidget()],
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

  Widget clipsWidget() {
    return Container(
      height: 400,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              roundedContainer(Icon(Icons.home), "Shop", () {}),
              roundedContainer(
                  Icon(Icons.picture_in_picture), "Categories", () {}),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              roundedContainer(Icon(Icons.add_alert), "Notification", () {}),
              roundedContainer(Icon(Icons.app_registration), "Register", () {}),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              roundedContainer(
                  Icon(Icons.article_outlined), "Terms & Condition", () {}),
              roundedContainer(Icon(Icons.verified_user_outlined),
                  "Privacy & Policy", () {}),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              roundedContainer(
                  Icon(Icons.settings_outlined), "Settings", () {}),
            ],
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  Widget roundedContainer(Icon i, assetName, Function todo) {
    return Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Hero(
              tag: "image-",
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: todo,
                iconSize: 21,
                icon: i,
              ),
            ),
            Text(
              "${assetName}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ));
  }

  Widget sectionHeader(String headerTitle, {onViewMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(headerTitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins')),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 2),
          child: FlatButton(
            onPressed: onViewMore,
            child: Text('Voir plus ›',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
          ),
        )
      ],
    );
  }

  Widget deals1(String dealTitle, {onViewMore, List<Widget> items}) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: (items != null)
                  ? items
                  : <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('No items available at this moment.',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Poppins')),
                      )
                    ],
            ),
          )
        ],
      ),
    );
  }
}
