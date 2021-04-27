import 'package:flutter/material.dart';
import 'package:mystore/SizeConfig.dart';
import 'package:mystore/components/cached_image.dart';

class LmaidaCard extends StatelessWidget {
  final String imagePath;
  final GestureTapCallback onTap;

  LmaidaCard({
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth - 100,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: cachedNetworkImage(imagePath)),
        ),
      ),
    );
  }
}
