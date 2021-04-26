import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mystore/components/cached_image.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/home/Conposante/lmaida_card.dart';
import 'package:mystore/models/shop.dart';

class StoreBodyDetails extends StatefulWidget {
  final ShopModel shopModel;

  const StoreBodyDetails({Key key, this.shopModel}) : super(key: key);

  @override
  _StoreBodyDetailsState createState() => _StoreBodyDetailsState();
}

class _StoreBodyDetailsState extends State<StoreBodyDetails> {
  bool loading = true;
  List<DocumentSnapshot> foodList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            deals1(widget.shopModel.name, onViewMore: () {}, items: <Widget>[
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
            _buildPopularList(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildPopularList() {
    if (!loading) {
      if (widget.shopModel.productList == null) {
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
            itemCount: widget.shopModel.productList.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              return card(
                  widget.shopModel.productList[index].mediaUrl,
                  widget.shopModel.productList[index].product_name,
                  widget.shopModel.productList[index].description,
                  widget.shopModel.productList[index].price,
                  index);
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

  Widget card(mediaUrl, product_name, description, price, int type) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          color: type.isEven ? Colors.white : Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: Color(0xFFB0CCE1).withOpacity(0.32),
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
                      onPressed: () {},
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
