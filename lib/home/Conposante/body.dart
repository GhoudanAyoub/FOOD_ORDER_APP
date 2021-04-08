import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/models/User.dart';

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
            height: 80.0,
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Expanded(
                  child: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                        "Lorem Ipsum is simply dummy text of the\n"
                        " printing and typesetting industry.  \nstandard dummy text ever since the 15",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                ),
              )),
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
