import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/Inbox/components/recent_chats.dart';
import 'package:mystore/components/notification_items.dart';
import 'package:mystore/models/notification.dart';
import 'package:mystore/utils/firebase.dart';

import 'components/notification_stream_wrapper.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  int pageIndex = 0;
  currentUserId() {
    return firebaseAuth.currentUser.uid;
  }

  final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(CupertinoIcons.chat_bubble_text)),
    new Tab(icon: new Icon(CupertinoIcons.chat_bubble_2_fill)),
  ]);

  Widget getBody2() {
    return Scaffold(
        appBar: new PreferredSize(
      preferredSize: tab.preferredSize,
      child: new Card(
        elevation: 26.0,
        color: Theme.of(context).primaryColor,
        child: tab,
      ),
    ));
  }

  List<Widget> containers = [
    Scaffold(
      body: ListView(
        children: [
          ActivityStreamWrapper(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              stream: notificationRef
                  .doc(firebaseAuth.currentUser.uid)
                  .collection('notifications')
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, DocumentSnapshot snapshot) {
                ActivityModel activities =
                    ActivityModel.fromJson(snapshot.data());
                return ActivityItems(
                  activity: activities,
                );
              })
        ],
      ),
    ),
    Chats(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          titleSpacing: 60,
          elevation: 1,
          title: Text(
            "Message ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: const FractionalOffset(0.3, 0.4),
                end: const FractionalOffset(0.5, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Chats(),
        ),
      ),
    );
  }

  deleteAllItems() async {
//delete all notifications associated with the authenticated user
    QuerySnapshot notificationsSnap = await notificationRef
        .doc(firebaseAuth.currentUser.uid)
        .collection('notifications')
        .get();
    notificationsSnap.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }
}
