import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mystore/Categories/components/cat_food.dart';
import 'package:mystore/Store/product_detail.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/item_card.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/models/categorie_model.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/services/post_service.dart';
import 'package:mystore/utils/firebase.dart';

import '../../constants.dart';

class Body extends StatefulWidget with NavigationStates {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserModel user1;
  List<DocumentSnapshot> foodList = [];
  List<DocumentSnapshot> catList = [];
  List<CategorieModel> _listCat = [];
  List<DocumentSnapshot> filtereProduct = [];
  bool loading = true;
  var fetCatResult;
  List<Product> _list = [];
  PostService postService = PostService();
  int _activeTab = 0;
  String CatName = "Restaurant";

  @override
  void initState() {
    getProducts();
    getCats();
    search("Restaurant");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
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
              top: 0.0,
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
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FlutterIcons.keyboard_backspace_mdi,
                            ),
                          ),
                          Badge(
                            position: BadgePosition.bottomStart(
                                bottom: -5.0, start: 4.0),
                            badgeContent: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            badgeColor: black,
                            child: Image.asset(
                              "assets/images/shopping_bag.png",
                              width: 45.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Top Food ",
                        style: TextStyle(
                          color: black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24.0),
                        height: 50,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _activeTab = index;
                                  CatName = _listCat[index].name;
                                  search(CatName);
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 450),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                height: 10,
                                decoration: BoxDecoration(
                                  color: _activeTab == index
                                      ? kTextColor1
                                      : kTextColor1.withOpacity(
                                          .2,
                                        ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                  child: Text(
                                    _listCat[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _activeTab == index
                                          ? Colors.white
                                          : kTextColor1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 15.0,
                            );
                          },
                          itemCount: _listCat.length,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(
                          milliseconds: 450,
                        ),
                        child: _buildPopularList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*ListView(
              children: [
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
                    child: _buildCatList()),
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
            )*/
          ],
        ),
      ),
    );
  }

  search(String query) {
    if (query == "") {
      filtereProduct = foodList;
    } else {
      List userSearch = foodList.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['categories'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filtereProduct = userSearch;
      });
    }
  }

  Widget _buildPopularList() {
    if (!loading) {
      if (filtereProduct.isEmpty) {
        return Container(
          height: 200,
          child: Center(
            child: Text("No ${CatName} Food Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // Lets create a coffee model and populate it
            itemCount: filtereProduct.length,
            crossAxisCount: 4,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot doc = filtereProduct[index];
              Product p = Product.fromJson(doc.data());
              if (p.categories == CatName)
                return card(p.mediaUrl, p.product_name, p.description, p.price,
                    index, p);
              else
                return Container(
                  height: 20,
                );
            },
            staggeredTileBuilder: (int index) => StaggeredTile.count(2, 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      }
/*
      Container(
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
      );*/
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  getProducts() async {
    QuerySnapshot snap = await productRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    foodList = doc;
    filtereProduct = doc;

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      product: product,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(1, 2),
                blurRadius: 6.0,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Image.network(
                  mediaUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product_name}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${description}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kTextColor1,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${price}",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FlutterIcons.add_circle_mdi,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    /*
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
                    child: Image.network(
                      mediaUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
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
        ));*/
  }
}
