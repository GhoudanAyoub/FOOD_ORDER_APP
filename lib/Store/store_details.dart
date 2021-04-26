import 'package:flutter/material.dart';
import 'package:mystore/Store/componant/Bodydetail.dart';
import 'package:mystore/models/shop.dart';

class StoreDetail extends StatelessWidget {
  static String routeName = "/storeDetail";
  final ShopModel shopModel;

  const StoreDetail({Key key, this.shopModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreBodyDetails(
      shopModel: shopModel,
    );
  }
}
