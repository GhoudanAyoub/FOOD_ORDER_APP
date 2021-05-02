import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mystore/components/custom_card.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/text_form_builder.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:mystore/utils/validation.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'edit_profile__model_view.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel user;
  bool valuesecond = false;

  String currentUid() {
    return firebaseAuth.currentUser.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valuesecond = widget.user.msgToAll;
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return ModalProgressHUD(
      progressIndicator: circularProgress(context),
      inAsyncCall: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          centerTitle: true,
          backgroundColor: kTextColor1.withOpacity(0.1),
          title: Text(
            "EDIT PROFILE",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () => viewModel.editProfile(context),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
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
            ListView(
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: GestureDetector(
                    onTap: () => viewModel.pickImage(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: new Offset(0.0, 0.0),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: viewModel.imgLink != null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(viewModel.imgLink),
                              ),
                            )
                          : viewModel.image == null
                              ? Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage:
                                        NetworkImage(widget.user.photoUrl),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage: FileImage(viewModel.image),
                                  ),
                                ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                buildForm(viewModel, context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForm(EditProfileViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: widget.user.username,
              prefix: Feather.user,
              hintText: "Username",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateName,
              onSaved: (String val) {
                viewModel.setUsername(val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: widget.user.bio,
              prefix: Feather.info,
              hintText: "Bio",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateField,
              onSaved: (String val) {
                viewModel.setBio(val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: widget.user.country,
              prefix: Feather.map,
              hintText: "Country",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateAddress,
              onSaved: (String val) {
                viewModel.setCountry(val);
              },
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 350,
                          child: Theme(
                              data: ThemeData(
                                primaryColor: Theme.of(context).accentColor,
                                accentColor: Theme.of(context).accentColor,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          value: this.valuesecond,
                                          checkColor: Colors.redAccent,
                                          activeColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.valuesecond = value;
                                              viewModel
                                                  .setMsgAll(this.valuesecond);
                                            });
                                          }),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "Receive Message From All",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
