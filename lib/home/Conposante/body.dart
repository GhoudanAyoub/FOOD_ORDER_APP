import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/Categories/components/cat_food.dart';
import 'package:mystore/Store/product_detail.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/cached_image.dart';
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
  List<CategorieModel> _listCat = [];
  bool loading = true;
  var fetCatResult;
  List<Product> _list = [];
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
                Colors.white70,
                Colors.white60,
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
            /*
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
                        color: Colors.redAccent,
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
            ),*/
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigationEvents.CategoriesClickedEvent);
                    },
                    child: Text("See all",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        )),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              child: Expanded(
                child: _buildCatList(),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Food ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  GestureDetector(
                    onTap: () {},
                    child: Text("See all",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        )),
                  )
                ],
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
      return Container(
        height: 300,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: foodList.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return card(
                _list[index].mediaUrl,
                _list[index].product_name,
                _list[index].description,
                _list[index].price,
                index,
                _list[index]);
          },
        ),
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
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 8,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return ItemCard(
              svgSrc: _listCat[index].picture,
              title: _listCat[index].name,
              press: () {
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

  Widget card(
      mediaUrl, product_name, description, price, int type, Product product) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          color: type.isEven ? Colors.white : Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 20,
              color: Colors.grey.withOpacity(0.32),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: 180,
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: cachedNetworkImage(mediaUrl),
                    /*
                    Image.network(
                      mediaUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),*/
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${product_name}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: type.isEven ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${description}",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: type.isEven ? Colors.black : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\$${price}",
                      style: TextStyle(
                        fontSize: 16,
                        color: type.isEven ? Colors.redAccent : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: type.isEven
                          ? Colors.redAccent
                          : Colors.grey.withOpacity(0.5),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      product: product,
                                    )));
                      },
                      child: Text(
                        "Order",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Lato-Regular.ttf',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ));
  }
}
