import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/home/Conposante/lmaida_card.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/models/shop.dart';
import 'package:mystore/utils/firebase.dart';

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
  List<Product> _list = [];

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 10,
      ),
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
        child: ListView(
          children: [
            deals1(widget.shopModel.name, onViewMore: () {}, items: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: LmaidaCard(
                    onTap: () => {},
                    imagePath: widget.shopModel.mediaUrl != null
                        ? widget.shopModel.mediaUrl
                        : 'https://static3.depositphotos.com/1003631/209/i/950/depositphotos_2099183-stock-photo-fine-table-setting-in-gourmet.jpg', //'imagePaths[index]',
                  ),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Beverages",
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
            _buildBeverages(),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lunch",
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
            _buildLunch(),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Desserts",
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
            _buildDesserts()
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
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 20,
              color: Color(0xFFB0CCE1).withOpacity(0.8),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: 200,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${product_name}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${description}",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
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
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      product: product,
                                    )));
                      },
                      child: Card(
                          elevation: 4.0,
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "View",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white70, size: 15.0)
                              ],
                            ),
                          )),
                    )
                  ],
                )
              ],
            ))
          ],
        ));
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
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
