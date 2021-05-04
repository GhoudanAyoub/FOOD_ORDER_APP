import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mystore/Inbox/components/conversation.dart';
import 'package:mystore/SignIn/sign_in_screen.dart';
import 'package:mystore/Store/store_details.dart';
import 'package:mystore/components/indicators.dart';
import 'package:mystore/components/rating_stars.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/models/shop.dart';
import 'package:mystore/profile/components/body.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  User user;
  TextEditingController searchController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];
  List<DocumentSnapshot> filteredUsers = [];
  List<DocumentSnapshot> shoplist = [];
  List<DocumentSnapshot> filteredShops = [];
  bool loading = true;
  double rating = 3.5;

  currentUserId() {
    return firebaseAuth.currentUser.uid;
  }

  getUsers() async {
    QuerySnapshot snap = await usersRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    users = doc;
    filteredUsers = doc;
    setState(() {
      loading = false;
    });
  }

  getShops() async {
    QuerySnapshot snap = await shopRef.get();
    List<DocumentSnapshot> doc = snap.docs;
    shoplist = doc;
    filteredShops = doc;
    setState(() {
      loading = false;
    });
  }

  search(String query) {
    if (query == "") {
      filteredUsers = users;
    } else {
      List userSearch = users.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['username'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredUsers = userSearch;
      });

      List shopSearch = shoplist.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['name'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredShops = shopSearch;
      });
    }
  }

  removeFromList(index) {
    filteredUsers.removeAt(index);
  }

  @override
  void initState() {
    getUsers();
    getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getAllUsers();
  }

  Widget getAllUsers() {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return SafeArea(
          child: Scaffold(
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
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 15.0),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(50.0),
                              child: TextFormField(
                                  cursorColor: black,
                                  controller: searchController,
                                  onChanged: (query) {
                                    search(query);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.search,
                                          color: GBottomNav, size: 30.0),
                                      contentPadding: EdgeInsets.only(
                                          left: 15.0, top: 15.0),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SFProDisplay-Black'))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Search Results',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                            child: Text('Users',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: buildUsers()),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 15, 10, 0),
                            child: Text('Shops',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: buildShops())
                        ],
                      )),
                ),
              ),
            ),
            /*ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.CategoriesClickedEvent);
                        },
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
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: _buildCatList()),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Top Food ",
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
              ],
            )*/
          ],
        ),
      ));
    });
  }

  buildShops() {
    if (!loading) {
      if (filteredShops.isEmpty) {
        return Center(
          child: Text("No Shop Found",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
      } else {
        return Container(
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // Lets create a coffee model and populate it
            itemCount: filteredShops.length,
            crossAxisCount: 4,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot doc = filteredShops[index];
              ShopModel shops = ShopModel.fromJson(doc.data());
              return ShopsCard(shops);
            },
            staggeredTileBuilder: (int index) => StaggeredTile.count(2, 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
        /*return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 0.7,
          physics: ClampingScrollPhysics(),
          children: List.generate(filteredShops.length, (index) {
            DocumentSnapshot doc = filteredShops[index];
            ShopModel shops = ShopModel.fromJson(doc.data());
            return ShopsCard(shops);
          }),
        );

        Container(
            child: ListView.builder(
          itemCount: filteredShops.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = filteredShops[index];
            ShopModel shops = ShopModel.fromJson(doc.data());
            return ShopsCard(shops);
          },
        ));*/
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  ShopsCard(ShopModel shops) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoreDetail(
                      shopModel: shops,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(1, 2),
                blurRadius: 6.0,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Image.network(
                  shops.mediaUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${shops.name}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: kTextColor1,
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StarRating(
                          rating: rating,
                          color: Colors.yellow[700],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    /* Container(
        margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
        padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 4),
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                height: 120,
                width: 180,
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
            Text(
              "${shops.name}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarRating(
                  rating: rating,
                  color: Colors.yellow[700],
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreDetail(
                              shopModel: shops,
                            )));
              },
              child: Card(
                  elevation: 4.0,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View",
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
          ],
        ));*/
  }

  buildUsers() {
    if (!loading) {
      if (filteredUsers.isEmpty) {
        return Center(
          child: Text("No User Found",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
      } else {
        return ListView.builder(
          itemCount: filteredUsers.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = filteredUsers[index];
            UserModel user = UserModel.fromJson(doc.data());
            if (firebaseAuth.currentUser != null && doc.id == currentUserId()) {
              checkIfFollowing(user.id);
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  removeFromList(index);
                });
              });
            }
            return Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(user.photoUrl != null &&
                              user.photoUrl != ""
                          ? user.photoUrl
                          : "https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                    ),
                    title: Text(user?.username,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    trailing: user.msgToAll == true
                        ? GestureDetector(
                            onTap: () {
                              firebaseAuth.currentUser == null
                                  ? SignInForMessage(context)
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Conversation(
                                          userId: doc.id,
                                          chatId: 'newChat',
                                        ),
                                      ));
                            },
                            child: Icon(CupertinoIcons.chat_bubble_fill,
                                color: Colors.redAccent),
                          )
                        : Container(
                            width: 1,
                          ),
                  ),
                ],
              ),
            );
          },
        );
      }
    } else {
      return Center(
        child: circularProgress(context),
      );
    }
  }

  SignInForMessage(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.red[800],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }

  showProfile(BuildContext context, {String profileId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Body(profileId: profileId),
        ));
  }

  checkIfFollowing(profileId) async {
    DocumentSnapshot doc = await followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
