import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mystore/VM/posts_view_model.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/custom_card.dart';
import 'package:mystore/components/custom_image.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/models/shop.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:provider/provider.dart';

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
  List<DocumentSnapshot> shoplist = [];
  Set<String> selectedValues = null;
  List<MultiSelectDialogItem<String>> multiItem = List();
  String dropdownValue = 'Lunch';
  String dropdownValueFlavour = 'cool';
  String dropdownValueCategories = 'Restaurant';

  @override
  void initState() {
    getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel viewModel = Provider.of<ProductViewModel>(context);
    return ModalProgressHUD(
        progressIndicator: circularProgress(context),
        inAsyncCall: viewModel.loading,
        child: Scaffold(
            key: viewModel.scaffoldKey,
            body: Container(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
              child: SingleChildScrollView(
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                      child: Container(
                          height: SizeConfig.screenHeight * 0.85,
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: SingleChildScrollView(
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  width: SizeConfig.screenWidth,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () => showImageChoices(
                                                    context, viewModel),
                                                child: Container(
                                                  width: 230,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[500],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                  child: viewModel.imgLink !=
                                                          null
                                                      ? CustomImage(
                                                          imageUrl:
                                                              viewModel.imgLink,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              30,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : viewModel.mediaUrl ==
                                                              null
                                                          ? Center(
                                                              child: Icon(
                                                                Icons
                                                                    .add_circle_outline,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : Image.file(
                                                              viewModel
                                                                  .mediaUrl,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  30,
                                                              fit: BoxFit.cover,
                                                            ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () =>
                                                        showImageChoices2(
                                                            context, viewModel),
                                                    child: Container(
                                                      width: 100,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[500],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                      child: viewModel
                                                                  .imgLink !=
                                                              null
                                                          ? CustomImage(
                                                              imageUrl:
                                                                  viewModel
                                                                      .imgLink,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  30,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : viewModel.mediaUrl2 ==
                                                                  null
                                                              ? Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_circle_outline,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              : Image.file(
                                                                  viewModel
                                                                      .mediaUrl2,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      30,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () =>
                                                        showImageChoices3(
                                                            context, viewModel),
                                                    child: Container(
                                                      width: 100,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[500],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                      child: viewModel
                                                                  .imgLink !=
                                                              null
                                                          ? CustomImage(
                                                              imageUrl:
                                                                  viewModel
                                                                      .imgLink,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  30,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : viewModel.mediaUrl3 ==
                                                                  null
                                                              ? Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_circle_outline,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              : Image.file(
                                                                  viewModel
                                                                      .mediaUrl3,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      30,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormBuilder(
                                          prefix: Feather.user,
                                          textInputType: TextInputType.name,
                                          controller: _nameContoller,
                                          hintText: "Product Name",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormBuilder(
                                          prefix: Feather.info,
                                          textInputType:
                                              TextInputType.multiline,
                                          controller: _descContoller,
                                          hintText: "Description",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormBuilder(
                                          prefix: Feather.dollar_sign,
                                          textInputType: TextInputType.number,
                                          controller: _priceContoller,
                                          hintText: "Price",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Food Categories :",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCard(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Theme(
                                                        data: ThemeData(
                                                          primaryColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          accentColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                        child: DropdownButton<
                                                                String>(
                                                            value: dropdownValueCategories ??
                                                                dropdownValueCategories,
                                                            icon: Icon(Icons
                                                                .arrow_drop_down),
                                                            iconSize: 32,
                                                            underline:
                                                                SizedBox(),
                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                dropdownValueCategories =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              'Fast Food',
                                                              'Restaurant',
                                                              'Chinois',
                                                              'Healthy',
                                                              'Américain',
                                                              'Snack',
                                                              'Fait maison',
                                                              'Burger',
                                                              'Marocain',
                                                              'Indien',
                                                              'Français',
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList()),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Food Type :",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCard(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Theme(
                                                        data: ThemeData(
                                                          primaryColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          accentColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                        child: DropdownButton<
                                                                String>(
                                                            value:
                                                                dropdownValue ??
                                                                    dropdownValue,
                                                            icon: Icon(Icons
                                                                .arrow_drop_down),
                                                            iconSize: 32,
                                                            underline:
                                                                SizedBox(),
                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                dropdownValue =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              'Lunch',
                                                              'Desserts',
                                                              'Beverages',
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList()),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Food Flavours :",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomCard(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Theme(
                                                        data: ThemeData(
                                                          primaryColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          accentColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                        child: DropdownButton<
                                                                String>(
                                                            value: dropdownValueFlavour ??
                                                                dropdownValueFlavour,
                                                            icon: Icon(Icons
                                                                .arrow_drop_down),
                                                            iconSize: 32,
                                                            underline:
                                                                SizedBox(),
                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                dropdownValueFlavour =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              'sweet',
                                                              'bitter',
                                                              'sour',
                                                              'salty',
                                                              'meaty ',
                                                              'cool',
                                                              'hot',
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList()),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Shops :",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomCard(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 5, 20, 5),
                                                child: Theme(
                                                  data: ThemeData(
                                                    primaryColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                    accentColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showMultiSelect(context);
                                                    },
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .shopping_cart,
                                                        size: 20,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        DefaultButton(
                                          text: "Done",
                                          press: () async {
                                            viewModel.setProductName(
                                                _nameContoller.text);
                                            viewModel.setBPrice(
                                                _priceContoller.text);
                                            viewModel.setDescription(
                                                _descContoller.text);
                                            viewModel.setSType(dropdownValue);
                                            viewModel.setFlavours(
                                                dropdownValueFlavour);
                                            viewModel.setShops(
                                                selectedValues.join(","));
                                            viewModel.setCategories(
                                                dropdownValueCategories);
                                            if (_formKey.currentState
                                                    .validate() &&
                                                selectedValues != null) {
                                              await viewModel.uploadPosts();
                                              viewModel.resetPost();
                                            }
                                          },
                                          submitted: false,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _showMultiSelect(BuildContext context) async {
    selectedValues = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: multiItem,
        );
      },
    );
    print('****>${selectedValues != null ? selectedValues.join(",") : "1"} ');
  }

  showImageChoices(BuildContext context, ProductViewModel viewModel) {
    showModalBottomSheet(
      backgroundColor: Colors.redAccent,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Feather.camera,
                  color: Colors.white,
                ),
                title: Text('Camera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(camera: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Feather.image,
                  color: Colors.white,
                ),
                title: Text('Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  showImageChoices2(BuildContext context, ProductViewModel viewModel) {
    showModalBottomSheet(
      backgroundColor: Colors.redAccent,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Feather.camera,
                  color: Colors.white,
                ),
                title: Text('Camera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage2(camera: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Feather.image,
                  color: Colors.white,
                ),
                title: Text('Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage2();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  showImageChoices3(BuildContext context, ProductViewModel viewModel) {
    showModalBottomSheet(
      backgroundColor: Colors.redAccent,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Feather.camera,
                  color: Colors.white,
                ),
                title: Text('Camera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage3(camera: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Feather.image,
                  color: Colors.white,
                ),
                title: Text('Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage3();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  getShops() async {
    QuerySnapshot snap = await shopRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    shoplist = doc;
    for (var fl in shoplist) {
      DocumentSnapshot doc1 = fl;
      ShopModel u = ShopModel.fromJson(doc1.data());
      multiItem.add(MultiSelectDialogItem(u.id, u.name));
    }
  }
}

// ================== copied from stakeOverFlow

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Store Selection',
            style: TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
              fontWeight: FontWeight.normal,
            )),
      ),
      contentPadding: EdgeInsets.only(top: 5.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.grey,
          child: Text('CANCEL',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              )),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          color: Colors.redAccent,
          child: Text('OK',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      checkColor: Colors.redAccent,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
