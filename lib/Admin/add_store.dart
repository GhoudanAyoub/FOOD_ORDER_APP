import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mystore/VM/StoreViewModel.dart';
import 'package:mystore/components/custom_image.dart';
import 'package:mystore/components/default_button.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:provider/provider.dart';

import '../SizeConfig.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _StatusContoller = TextEditingController();
  var submitted = false;
  bool state1 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StoreViewModel viewModel = Provider.of<StoreViewModel>(context);
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
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                    child: Container(
                        height: SizeConfig.screenHeight * 0.5,
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
                                                  height: 180,
                                                  width: 320,
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
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormBuilder(
                                        prefix: Feather.user,
                                        initialValue: viewModel.store_name,
                                        textInputType: TextInputType.name,
                                        controller: _nameContoller,
                                        hintText: "Store Name",
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DefaultButton(
                                        text: "Done",
                                        press: () async {
                                          viewModel.setStoreName(
                                              _nameContoller.text);
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
                ),
              ),
            )));
  }

  showImageChoices(BuildContext context, StoreViewModel viewModel) {
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
}
