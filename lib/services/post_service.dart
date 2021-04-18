import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mystore/models/User.dart';
import 'package:mystore/services/services.dart';
import 'package:mystore/utils/firebase.dart';
import 'package:uuid/uuid.dart';

class PostService extends Service {
  String postId = Uuid().v4();
  UserModel user;

  uploadProfilePicture(File image, User user) async {
    String link = await uploadImage(profilePic, image);
    var ref = usersRef.doc(user.uid);
    ref.update({
      "photoUrl": link,
    });
  }

  uploadPost(
      {File image,
      File image2,
      File image3,
      String product_name,
      String price,
      String description,
      flavours}) async {
    String link = await uploadImage(products, image);
    String link2 = await uploadImage(products, image2);
    String link3 = await uploadImage(products, image3);
    var ref = productRef.doc();
    ref.set({
      "id": ref.id,
      "postId": ref.id,
      "ownerId": firebaseAuth.currentUser.uid,
      "product_name": product_name,
      "price": price,
      "mediaUrl": link,
      "mediaUrl2": link2,
      "mediaUrl3": link3,
      "flavours": flavours,
      "description": description == null ? "" : description,
      "timestamp": Timestamp.now(),
    }).catchError((e) {
      print(e);
    });
  }

  uploadComment(String username, String comment, String userDp, String userId,
      String postId) async {
    await commentRef.doc(postId).collection("comments").add({
      "username": username,
      "comment": comment,
      "timestamp": Timestamp.now(),
      "userDp": userDp,
      "userId": userId,
    });
  }

  addCommentToNotification(
      String type,
      String commentData,
      String username,
      String userId,
      String postId,
      String mediaUrl,
      String ownerId,
      String userDp) async {
    await notificationRef.doc(ownerId).collection('notifications').add({
      "type": type,
      "commentData": commentData,
      "username": username,
      "userId": userId,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }

  addLikesToNotification(String type, String username, String userId,
      String postId, String mediaUrl, String ownerId, String userDp) async {
    await notificationRef
        .doc(ownerId)
        .collection('notifications')
        .doc(postId)
        .set({
      "type": type,
      "username": username,
      "userId": firebaseAuth.currentUser.uid,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }

  uploadStore({File image, String store_name}) async {
    String link = await uploadImage(products, image);
    var ref = shopRef.doc();
    ref.set({
      "id": ref.id,
      "name": store_name,
      "mediaUrl": link,
      "status": false,
      "productList": null,
      "orders": null,
      "completedOrders": null,
      "canceledOrders": null,
    }).catchError((e) {
      print(e);
    });
  }

  uploadCat({String image, String name}) async {
    var ref = catRef.doc();
    ref.set({
      "id": ref.id,
      "name": name,
      "picture": image,
    }).catchError((e) {
      print(e);
    });
  }
}
