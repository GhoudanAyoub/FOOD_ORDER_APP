import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/SignIn/sign_in_screen.dart';
import 'package:mystore/SignUp/sign_up_screen.dart';
import 'package:mystore/components/rating_stars.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/utils/validation.dart';

import '../../constants.dart';

class ProductDetailsBody extends StatefulWidget {
  final Product product;

  const ProductDetailsBody({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsBody> {
  double rating = 3.5;
  bool seemore = false;
  String dropdownValue = '2';
  bool _value = false;
  bool _value2 = false;
  bool _value3 = false;
  bool PickUpcheckedValue = false;
  bool DeliverycheckedValue = false;
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            left: -70.0,
            bottom: -40.0,
            child: Image.asset(
              "assets/images/drum.png",
            ),
          ),
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
                    image: NetworkImage(widget.product.mediaUrl)),
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
            top: 280.0,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Container(
                height: 550,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(
                  children: [
                    Text(
                      "${widget.product.product_name}",
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${widget.product.description}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTextColor1,
                        height: 1.8,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(),
                    Text("Quantity",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.grey,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),

                      // dropdown below..
                      child: DropdownButton<String>(
                          value: dropdownValue ?? dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 32,
                          underline: SizedBox(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
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
                          }).toList()),
                    ),
                    Text("Flavour",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 250, 10),
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
                    Text("Delivery Option",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    CheckboxListTile(
                      title: Text("PickUp"),
                      value: PickUpcheckedValue, activeColor: white,
                      onChanged: (newValue) {
                        setState(() {
                          PickUpcheckedValue = newValue;
                          DeliverycheckedValue = !newValue;
                        });
                      },
                      checkColor: Colors.redAccent,
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      title: Text("DoorStep Delivery"),
                      value: DeliverycheckedValue, activeColor: white,
                      onChanged: (newValue) {
                        setState(() {
                          DeliverycheckedValue = newValue;
                          PickUpcheckedValue = !newValue;
                        });
                      },
                      checkColor: Colors.redAccent,
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DeliverycheckedValue == false
                        ? Container(
                            width: double.infinity,
                            height: 50,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              color: kTextColor1,
                              onPressed: () {
                                //firebaseAuth.currentUser == null?

                                logIn(context);

                                /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreDetail(
                              shopModel: shops,
                            )));*/
                              },
                              child: Text(
                                "Add to my cart",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    DeliverycheckedValue == true
                        ? AddressCard(widget.product)
                        : Container(
                            height: 0,
                          ),
                    Divider(),
                  ],
                ),
              ),
            ),
          )
        ],
      )

          /*ListView(
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
        ),*/
          ),
    );
  }

  Widget doubleColText(String textOne, String textTwo) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textOne,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          Text(
            textTwo,
            style: TextStyle(
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  ShopsCard(Product shops) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 15, 10, 15),
        padding: EdgeInsets.fromLTRB(0, 2, 20, 2),
        width: 200,
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
                        child: Image.network(
                          shops.mediaUrl,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
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
                  width: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${shops.product_name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    StarRating(
                      rating: rating,
                      color: Colors.yellow[700],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          seemore = !seemore;
                        });
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "See more",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Lato-Regular.ttf',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.white70, size: 15.0)
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            seemore == true
                ? Padding(
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
                  )
                : Container(
                    height: 0,
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
              child: Text("Quantity",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 2, 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 100,
              height: 40,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 8,
                  color: Colors.grey,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),

              // dropdown below..
              child: DropdownButton<String>(
                  value: dropdownValue ?? dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  underline: SizedBox(),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
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
                  }).toList()),
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
                          //firebaseAuth.currentUser == null?

                          logIn(context);

                          /* Navigator.push(
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
        child: Form(
          key: _formKey,
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
                  validateFunction: Validations.validateAddress,
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
                  if (_formKey.currentState.validate()) {
                    //firebaseAuth.currentUser == null?
                    logIn(context);
                    /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreDetail(
                              shopModel: shops,
                            )));*/
                  }
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
          ),
        ));
  }

  logIn(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            children: [
              Icon(
                CupertinoIcons.info,
                color: Colors.redAccent,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "You Must login before Order",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Center(
                  child:
                      Text('Register', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          );
        });
  }
}
