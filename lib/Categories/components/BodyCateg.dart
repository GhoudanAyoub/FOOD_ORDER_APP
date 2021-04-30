import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Categories/components/cat_food.dart';
import 'package:mystore/components/indicators.dart';
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
            height: 600,
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(filteredCat.length, (index) {
                return Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        color: Color(0xFFB0CCE1).withOpacity(0.32),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CategoriesFood(
                                name: _listCat[index].name,
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                _listCat[index].picture,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _listCat[index].name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ));
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
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
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
