import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/category.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/models/shop.dart';
import 'package:mystore/utils/firebase.dart';

import '../../constants.dart';
import '../componant/beverage_page.dart';
import '../product_detail.dart';

class StoreBodyDetails extends StatefulWidget {
  final ShopModel shopModel;

  const StoreBodyDetails({Key key, this.shopModel}) : super(key: key);

  @override
  _StoreBodyDetailsState createState() => _StoreBodyDetailsState();
}

class _StoreBodyDetailsState extends State<StoreBodyDetails> {
  bool loading = true;
  List<DocumentSnapshot> foodList = [];
  static List<Product> _list = [];
  String CatName = "";
  int _activeTab = 0;
  List pages = [
    BeveragePage(
      list: _list,
      type: "Beverages",
    ),
    BeveragePage(
      list: _list,
      type: "Lunch",
    ),
    BeveragePage(
      list: _list,
      type: "Desserts",
    ),
  ];

  static final List<Category> categories = [
    Category(
      id: 1,
      name: "Beverages",
    ),
    Category(
      id: 2,
      name: "Lunch",
    ),
    Category(
      id: 3,
      name: "Desserts",
    ),
  ];
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    QuerySnapshot snap = await productRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    foodList = doc;

    for (var fl in foodList) {
      DocumentSnapshot doc1 = fl;
      Product p1 = Product.fromJson(doc1.data());
      var p1list = p1.shops.split(',');
      if (p1list.contains(widget.shopModel.id)) _list.add(p1);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 300.0,
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.shopModel.mediaUrl != null
                          ? widget.shopModel.mediaUrl
                          : 'https://static3.depositphotos.com/1003631/209/i/950/depositphotos_2099183-stock-photo-fine-table-setting-in-gourmet.jpg')),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kToolbarHeight,
                    horizontal: 16.0,
                  ),
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FlutterIcons.keyboard_backspace_mdi,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 300.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Food ",
                              style: TextStyle(
                                color: black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              height: 50,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                // Let's create a model for categories and populate with data.
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _activeTab = index;
                                      });
                                    },
                                    // Little switch animation
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          categories[index].name,
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
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 15.0,
                                  );
                                },
                                itemCount: 3,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            AnimatedSwitcher(
                              duration: Duration(
                                milliseconds: 450,
                              ),
                              child: pages[_activeTab],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeverages() {
    if (!loading) {
      if (_list == null) {
        return Container(
          height: 300,
          child: Center(
            child: Text("No Product Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _list.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              if (_list[index].type.contains("Beverages"))
                return card(
                    _list[index].mediaUrl,
                    _list[index].product_name,
                    _list[index].description,
                    _list[index].price,
                    index,
                    _list[index]);
              else
                return Container(
                  height: 0,
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

  Widget _buildLunch() {
    if (!loading) {
      if (_list == null) {
        return Container(
          height: 300,
          child: Center(
            child: Text("No Product Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _list.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              if (_list[index].type.contains("Lunch"))
                return card(
                    _list[index].mediaUrl,
                    _list[index].product_name,
                    _list[index].description,
                    _list[index].price,
                    index,
                    _list[index]);
              else
                return Container(
                  height: 0,
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

  Widget _buildDesserts() {
    if (!loading) {
      if (_list == null) {
        return Container(
          height: 300,
          child: Center(
            child: Text("No Product Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _list.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              if (_list[index].type.contains("Desserts"))
                return card(
                    _list[index].mediaUrl,
                    _list[index].product_name,
                    _list[index].description,
                    _list[index].price,
                    index,
                    _list[index]);
              else
                return Container(
                  height: 0,
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
              Expanded(
                child: Container(
                  child: Image.network(
                    mediaUrl,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      style: TextStyle(
                        fontSize: 13.0,
                        color: kTextColor1,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
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
  }
}
