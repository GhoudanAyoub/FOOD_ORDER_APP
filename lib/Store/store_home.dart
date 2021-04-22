import 'package:flutter/material.dart';
import 'package:mystore/Store/componant/Body.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';

class StoreHome extends StatelessWidget with NavigationStates {
  static String routeName = "/store";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
