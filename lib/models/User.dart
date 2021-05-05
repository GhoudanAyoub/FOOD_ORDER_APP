import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String photoUrl;
  String country;
  String bio;
  String id;
  String phone;
  Timestamp signedUpAt;
  Timestamp lastSeen;
  bool isOnline;
  bool msgToAll;
  bool sub;
  bool admin;
  int orders;

  UserModel(
      {this.username,
      this.email,
      this.id,
      this.photoUrl,
      this.signedUpAt,
      this.isOnline,
      this.lastSeen,
      this.bio,
      this.country,
      this.phone,
      this.msgToAll,
      this.sub,
      this.orders,
      this.admin});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
    phone = json['phone'];
    msgToAll = json['msgToAll'];
    sub = json['sub'];
    orders = json['orders'];
    admin = json['admin'];
  }

  UserModel copy({String username}) => UserModel(
        username: username ?? this.username,
      );
}
