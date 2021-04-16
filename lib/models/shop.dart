import 'package:mystore/models/product.dart';

class ShopModel {
  var id;
  String name;
  String mediaUrl;
  bool status;
  List orders;
  List completedOrders;
  List canceledOrders;
  List<Product> productList;

  ShopModel(
      {this.id,
      this.name,
      this.mediaUrl,
      this.status,
      this.orders,
      this.productList,
      this.completedOrders,
      this.canceledOrders});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mediaUrl = json['mediaUrl'];
    status = json['status'];
    productList = json['productList'];
    orders = json['orders'];
    completedOrders = json['completedOrders'];
    canceledOrders = json['canceledOrders'];
  }
}
