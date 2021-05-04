import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/models/product.dart';

import '../product_detail.dart';

class BeveragePage extends StatefulWidget {
  final List list;
  final String type;
  const BeveragePage({Key key, this.list, this.type}) : super(key: key);

  @override
  _BeveragePageState createState() => _BeveragePageState();
}

class _BeveragePageState extends State<BeveragePage> {
  bool loading = true;
  List<DocumentSnapshot> foodList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (widget.list[index].type.contains(widget.type))
            return card(
                widget.list[index].mediaUrl,
                widget.list[index].product_name,
                widget.list[index].description,
                widget.list[index].price,
                index,
                widget.list[index]);
          else
            return Container(
              height: 0,
            );
        },
      ),
    );
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
      child: Container(
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
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  )
                ],
              ))
            ],
          )),
    );
  }
}
