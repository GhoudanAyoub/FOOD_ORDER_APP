import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/Admin/add_product.dart';
import 'package:mystore/Admin/bord.dart';
import 'package:mystore/Admin/customer.dart';
import 'package:mystore/Admin/shop_managment.dart';
import 'package:mystore/home/home_screen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  DashboardClickedEvent,
  ShopClickedEvent,
  CustomersClickedEvent,
  AddProductClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomeScreen();
        break;

      case NavigationEvents.DashboardClickedEvent:
        yield AdminBord();
        break;

      case NavigationEvents.ShopClickedEvent:
        yield Shop();
        break;

      case NavigationEvents.CustomersClickedEvent:
        yield Customers();
        break;

      case NavigationEvents.AddProductClickedEvent:
        yield AddProduct();
        break;
    }
  }
}
