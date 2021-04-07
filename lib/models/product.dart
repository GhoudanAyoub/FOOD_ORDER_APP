import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String postId;
  String ownerId;
  String product_name;
  String price;
  String description;
  String mediaUrl;
  String mediaUrl2;
  String mediaUrl3;
  List flavours;
  Timestamp timestamp;

  Product({
    this.id,
    this.postId,
    this.ownerId,
    this.price,
    this.description,
    this.mediaUrl,
    this.mediaUrl2,
    this.mediaUrl3,
    this.product_name,
    this.flavours,
    this.timestamp,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    price = json['price'];
    product_name = json['product_name'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    mediaUrl2 = json['mediaUrl2'];
    mediaUrl3 = json['mediaUrl3'];
    flavours = json['flavours'];
    timestamp = json['timestamp'];
  }
}
