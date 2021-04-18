import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/item_card.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/models/categorie_model.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/services/post_service.dart';
import 'package:mystore/utils/firebase.dart';

import 'lmaida_card.dart';

class Body extends StatefulWidget with NavigationStates {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserModel user1;
  List<DocumentSnapshot> foodList = [];
  List<DocumentSnapshot> catList = [];
  List<Product> _list = [];
  List<CategorieModel> _listCat = [];
  bool loading = true;
  var fetCatResult;
  PostService postService = PostService();

  @override
  void initState() {
    getProducts();
    getCats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.red[900],
              ],
              begin: const FractionalOffset(0.3, 0.4),
              end: const FractionalOffset(0.5, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView(
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
            Card(
              elevation: 8,
              color: Colors.white,
              margin: EdgeInsets.only(right: 20, left: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Flexible(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 25,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.red[700],
                        onPressed: () {},
                        child: Text(
                          "SEE MORE",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Lato-Regular.ttf',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Center(
                child: Text("Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              child: Expanded(
                child: _buildCatList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Center(
                child: Text("Recently Searched",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
              ),
            ),
            _buildPopularList(),
          ],
        ),
      ),
    );
  }

  getProducts() async {
    QuerySnapshot snap = await productRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    foodList = doc;

    for (var fl in foodList) {
      DocumentSnapshot doc1 = fl;
      _list.add(Product.fromJson(doc1.data()));
    }
    setState(() {
      loading = false;
    });
  }

  getCats() async {
    QuerySnapshot snap = await catRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    catList = doc;

    for (var fl in catList) {
      DocumentSnapshot doc1 = fl;
      _listCat.add(CategorieModel.fromJson(doc1.data()));
    }
    setState(() {
      loading = false;
    });
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

  Widget _buildPopularList() {
    if (!loading) {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: foodList.length,
        padding: EdgeInsets.only(
          left: 40,
          bottom: 16,
          top: 20,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    height: 100,
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _list[index].mediaUrl,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "${_list[index].product_name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "\$${_list[index].price}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${_list[index].description}",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 100,
                      height: 25,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        disabledColor: Colors.grey[400],
                        disabledTextColor: Colors.white60,
                        onPressed: () {},
                        child: Text(
                          "SEE MORE",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Lato-Regular.ttf',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          );
        },
      );
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  Widget _buildCatList() {
    if (!loading) {
      return Container(
        height: 180,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: catList.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(5),
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
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }
}
