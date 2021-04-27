import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Store/product_detail.dart';
import 'package:mystore/components/cached_image.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/utils/firebase.dart';

class CategoriesFood extends StatefulWidget {
  final String name;

  const CategoriesFood({Key key, this.name}) : super(key: key);
  @override
  _CategoriesFoodState createState() => _CategoriesFoodState();
}

class _CategoriesFoodState extends State<CategoriesFood> {
  List<DocumentSnapshot> foodList = [];
  List<Product> _list = [];
  bool loading = true;

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
      Product p = Product.fromJson(doc1.data());
      if (p.categories == widget.name) _list.add(p);
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
          elevation: 1,
          title: Center(
            child: Text("Categories : ${widget.name}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          )),
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
            _buildPopularList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularList() {
    if (!loading) {
      if (_list.isEmpty) {
        return Container(
          height: 300,
          child: Center(
            child: Text("No ${widget.name} Food Found",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        return Container(
            height: 600,
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: List.generate(_list.length, (index) {
                return card(
                    _list[index].mediaUrl,
                    _list[index].product_name,
                    _list[index].description,
                    _list[index].price,
                    index,
                    _list[index]);
              }),
            ));
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

/*
*
*

        Container(
        height: 300,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _list.length,
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
*
* */
  Widget card(
      mediaUrl, product_name, description, price, int type, Product product) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
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
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  child: Row(
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
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.redAccent,
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
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
