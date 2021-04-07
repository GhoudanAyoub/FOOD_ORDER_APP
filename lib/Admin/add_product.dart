import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mystore/VM/posts_view_model.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/custom_image.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/text_form_builder.dart';
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
              leading:
                  Image.asset('assets/images/pl.png', width: 100, height: 100),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                                                child: viewModel.imgLink != null
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
                                                    : viewModel.mediaUrl == null
                                                        ? Center(
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : Image.file(
                                                            viewModel.mediaUrl,
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
                                                  MainAxisAlignment.spaceAround,
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
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                    ),
                                                    child: viewModel.imgLink !=
                                                            null
                                                        ? CustomImage(
                                                            imageUrl: viewModel
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
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                    ),
                                                    child: viewModel.imgLink !=
                                                            null
                                                        ? CustomImage(
                                                            imageUrl: viewModel
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
                                        textInputType: TextInputType.multiline,
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
                                            "Flavours",
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
                                              Card(
                                                color: Colors.white,
                                                elevation: 8,
                                                child: Text(
                                                  "Chocolate",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: Colors.white,
                                                elevation: 8,
                                                child: Text(
                                                  "vanille",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: Colors.white,
                                                elevation: 8,
                                                child: Text(
                                                  "fddfdfd",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
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
                                          await viewModel.uploadPosts();
                                          viewModel.resetPost();
                                        },
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
            )));
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
}
