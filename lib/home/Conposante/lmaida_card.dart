import 'package:flutter/material.dart';
import 'package:mystore/SizeConfig.dart';

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
            child: Image.network(
              imagePath,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
