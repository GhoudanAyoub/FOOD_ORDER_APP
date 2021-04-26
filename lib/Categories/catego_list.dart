import 'package:flutter/material.dart';
import 'package:mystore/Categories/components/BodyCateg.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';

class CategoriesList extends StatelessWidget with NavigationStates {
  static String routeName = "/categories";
  @override
  Widget build(BuildContext context) {
    return BodyCateg();
  }
}
