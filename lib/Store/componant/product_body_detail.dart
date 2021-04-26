import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/components/cached_image.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/models/product.dart';

class ProductDetailsBody extends StatefulWidget {
  final Product product;

  const ProductDetailsBody({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsBody> {
  String dropdownValue = '2';
  bool _value = false;
  bool _value2 = false;
  bool _value3 = false;
  bool PickUpcheckedValue = false;
  bool DeliverycheckedValue = false;
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
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
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(widget.product.type,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            ShopsCard(widget.product),
            orderCard(widget.product),
            DeliverycheckedValue == true
                ? AddressCard(widget.product)
                : Container(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }

  ShopsCard(Product shops) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
        padding: EdgeInsets.fromLTRB(0, 2, 20, 2),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 15,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: 250,
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: cachedNetworkImage(shops.mediaUrl),
                        /*
                    Image.network(
                      shops.mediaUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),*/
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Flexible(
                      child: Text(
                        "${shops.product_name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ));
  }

  orderCard(Product shops) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
        padding: EdgeInsets.fromLTRB(0, 2, 20, 2),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 15,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text("Quatity",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 300, 0),
              child: DropdownButton<String>(
                value: dropdownValue ?? dropdownValue,
                icon: Icon(
                  CupertinoIcons.arrow_down_to_line,
                  color: Colors.black,
                  size: 20,
                ),
                elevation: 20,
                style: TextStyle(color: Colors.black),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                isExpanded: true,
                items: <String>[
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text("Flavour",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 250, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _value = !_value;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _value
                            ? Icon(
                                Icons.check,
                                size: 15.0,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _value2 = !_value2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _value2
                            ? Icon(
                                Icons.check,
                                size: 15.0,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _value3 = !_value3;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _value3
                            ? Icon(
                                Icons.check,
                                size: 15.0,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text("Delivery Option",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            CheckboxListTile(
              title: Text("PickUp"),
              value: PickUpcheckedValue,
              onChanged: (newValue) {
                setState(() {
                  PickUpcheckedValue = newValue;
                  DeliverycheckedValue = !newValue;
                });
              },
              checkColor: Colors.redAccent,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("DoorStep Delivery"),
              value: DeliverycheckedValue,
              onChanged: (newValue) {
                setState(() {
                  DeliverycheckedValue = newValue;
                  PickUpcheckedValue = !newValue;
                });
              },
              checkColor: Colors.redAccent,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            SizedBox(
              height: 10,
            ),
            DeliverycheckedValue == false
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreDetail(
                              shopModel: shops,
                            )));*/
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
                                    "ORDER",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.white70, size: 15.0)
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                : Container(
                    height: 0,
                  ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }

  AddressCard(Product shops) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
        padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 15,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text("Address",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormBuilder(
                prefix: Feather.map,
                hintText: "Address Line 1",
                controller: address1,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormBuilder(
                prefix: Feather.map,
                controller: address2,
                hintText: "Address Line 2",
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormBuilder(
                prefix: Feather.map,
                controller: address3,
                hintText: "Address Line 3",
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreDetail(
                              shopModel: shops,
                            )));*/
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
                          "Proceed to payment",
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
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
