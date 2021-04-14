import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mystore/VM/posts_view_model.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
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
  Set<int> selectedValues, flaveSelectedValues;
  List<MultiSelectDialogItem<int>> multiItem = List();
  List<MultiSelectDialogItem<int>> multiItem2 = List();

  Map<double, String> dataMap = {1: 'chocolate ', 2: 'vanilla ', 3: 'banana'};

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
            appBar: AppBar(
              elevation: 0,
              actions: <Widget>[
                Image.asset('assets/images/pl.png', width: 100, height: 100)
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
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                      child: Container(
                          height: SizeConfig.screenHeight * 0.8,
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
                                          initialValue: viewModel.product_name,
                                          textInputType: TextInputType.name,
                                          onChange: (val) =>
                                              viewModel.setProductName(
                                                  _nameContoller.text),
                                          onSaved: (val) =>
                                              viewModel.setProductName(
                                                  _nameContoller.text),
                                          controller: _nameContoller,
                                          hintText: "Product Name",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormBuilder(
                                          prefix: Feather.info,
                                          initialValue: viewModel.description,
                                          textInputType:
                                              TextInputType.multiline,
                                          onChange: (val) =>
                                              viewModel.setDescription(
                                                  _descContoller.text),
                                          onSaved: (val) =>
                                              viewModel.setDescription(
                                                  _descContoller.text),
                                          controller: _descContoller,
                                          hintText: "Description",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormBuilder(
                                          prefix: Feather.dollar_sign,
                                          initialValue: viewModel.price,
                                          textInputType: TextInputType.number,
                                          onChange: (val) => viewModel
                                              .setBPrice(_priceContoller.text),
                                          onSaved: (val) => viewModel
                                              .setBPrice(_priceContoller.text),
                                          controller: _priceContoller,
                                          hintText: "Price",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Shops And Flavours",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: FloatingActionButton(
                                                      shape: CircleBorder(),
                                                      onPressed: () {
                                                        _showMultiSelect(
                                                            context);
                                                      },
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                          CupertinoIcons
                                                              .shopping_cart,
                                                          size: 30,
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: FloatingActionButton(
                                                      shape: CircleBorder(),
                                                      onPressed: () {
                                                        _showMultiSelect2(
                                                            context);
                                                      },
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                          CupertinoIcons
                                                              .pin_fill,
                                                          size: 20,
                                                          color: Colors.black),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        DefaultButton(
                                          text: "Done",
                                          press: () async {
                                            if (_formKey.currentState
                                                .validate()) {
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
    selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: multiItem,
          initialSelectedValues: [
            1,
          ].toSet(),
        );
      },
    );
    print(
        '****>${selectedValues.isNotEmpty ? selectedValues.join(",") : "1"} ');
  }

  void _showMultiSelect2(BuildContext context) async {
    flaveSelectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: multiItem2,
          initialSelectedValues: [
            1,
          ].toSet(),
        );
      },
    );
    print(
        '****>${selectedValues.isNotEmpty ? selectedValues.join(",") : "1"} ');
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
    //dataMap.map((key, value) =>{ print(value);});
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
      title: Text('Select :'),
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
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
