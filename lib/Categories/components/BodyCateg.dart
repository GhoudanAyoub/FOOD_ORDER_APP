import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/item_card.dart';
import 'package:mystore/models/categorie_model.dart';
import 'package:mystore/utils/firebase.dart';

import '../../constants.dart';

class BodyCateg extends StatefulWidget {
  @override
  _BodyCategState createState() => _BodyCategState();
}

class _BodyCategState extends State<BodyCateg> {
  List<DocumentSnapshot> catList = [];
  List<CategorieModel> _listCat = [];
  List<DocumentSnapshot> filteredCat = [];
  bool loading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getCats();
    super.initState();
  }

  getCats() async {
    QuerySnapshot snap = await catRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    catList = doc;
    filteredCat = doc;

    for (var fl in filteredCat) {
      DocumentSnapshot doc1 = fl;
      _listCat.add(CategorieModel.fromJson(doc1.data()));
    }
    setState(() {
      loading = false;
    });
  }

  search(String query) {
    if (query == "") {
      filteredCat = catList;
    } else {
      List userSearch = catList.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['name'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredCat = userSearch;
      });
    }
  }

  Widget _buildCatList() {
    if (!loading) {
      if (filteredCat.isEmpty) {
        return Container(
          height: 300,
          child: Center(
            child: Text("No Categories Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
          child: ListView.builder(
            itemCount: filteredCat.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ItemCard(
                svgSrc: _listCat[index].picture,
                title: _listCat[index].name,
                press: () {
                  /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailsScreen();
                  },
                ),
              );*/
                },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.white70,
                Colors.redAccent,
              ],
              begin: const FractionalOffset(0.3, 0.4),
              end: const FractionalOffset(0.5, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 30, 20, 0),
            child: Text("Find Your Categories!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.color_filter,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
                              suffixIcon: Icon(Icons.search,
                                  color: Colors.grey, size: 30.0),
                              contentPadding:
                                  EdgeInsets.only(left: 15.0, top: 15.0),
                              hintText: 'Search Name',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ))),
                    ),
                  ),
                ],
              )),
          _buildCatList()
        ]),
      ),
    );
  }
}
