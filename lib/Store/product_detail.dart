import 'package:flutter/material.dart';
import 'package:mystore/Store/componant/product_body_detail.dart';
import 'package:mystore/models/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProductDetailsBody(
      product: product,
    );
  }
}
