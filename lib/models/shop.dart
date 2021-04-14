import 'package:mystore/models/product.dart';

class ShopModel {
  var id;
  String name;
  bool status;
  List orders;
  List completedOrders;
  List canceledOrders;
  Product product;

  ShopModel(
      {this.id,
      this.name,
      this.status,
      this.orders,
      this.product,
      this.completedOrders,
      this.canceledOrders});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    product = json['product'];
    orders = json['orders'];
    completedOrders = json['completedOrders'];
    canceledOrders = json['canceledOrders'];
  }
}
