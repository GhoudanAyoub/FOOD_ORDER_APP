import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/text_form_builder.dart';

import '../SizeConfig.dart';

class AddProduct extends StatefulWidget with NavigationStates {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _descContoller = TextEditingController();
  TextEditingController _priceContoller = TextEditingController();
  var submitted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Image.asset('assets/images/pl.png', width: 100, height: 100),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                chooseUpload2(context);
              },
              iconSize: 21,
              icon: Icon(Icons.list),
            )
          ],
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.red[600],
                  Colors.grey.withOpacity(0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Container(
                      height: SizeConfig.screenHeight * 0.8,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: SizeConfig.screenWidth,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormBuilder(
                                    prefix: Feather.user,
                                    controller: _nameContoller,
                                    hintText: "Product Name",
                                    textInputAction: TextInputAction.next,
                                  ),
                                  TextFormBuilder(
                                    prefix: Feather.info,
                                    controller: _descContoller,
                                    hintText: "Description",
                                    textInputAction: TextInputAction.next,
                                  ),
                                  TextFormBuilder(
                                    prefix: Feather.dollar_sign,
                                    controller: _priceContoller,
                                    hintText: "Price",
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 10,),
                                  DefaultButton(
                                    text: "Done",
                                    press: () {},
                                    submitted: false,
                                  ),
                                ],
                              ),
                            )),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  chooseUpload2(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.bottomCenter,
          width: 200,
          child: Container(
            height: 500,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.red[800],
                      endIndent: 200,
                      indent: 200,
                      thickness: 4,
                      height: 0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [clipsWidget2()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget clipsWidget2() {
    return Container(
      height: 400,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.DashboardClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.ShopClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Manage Shops",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.CustomersClickedEvent);
              Navigator.pop(context);
            },
            child: Text(
              "Manage Customers",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            "Reports",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
