// ignore_for_file: prefer_final_fields, depend_on_referenced_packages, library_private_types_in_public_api, prefer_const_constructors

import 'package:ecommerce_shopme/screens/account_screen/account_screen.dart';
import 'package:ecommerce_shopme/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_shopme/screens/home/home.dart';
import 'package:ecommerce_shopme/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({final Key? key,})
      : super(key: key);


  @override
  _CustomBottomBarState createState() =>_CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller= PersistentTabController();
  final bool _hideNavBar = false;


  List<Widget> _buildScreens() => [
    Home(),
    CartScreen(),
    OrderScreen(),
    AccountScreen(),


  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveIcon:Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
        inactiveColorSecondary: Colors.white),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      inactiveIcon:Icon(Icons.shopping_cart_outlined),
      title: "Cart",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,

    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_bag),
      inactiveIcon:Icon(Icons.shopping_bag_outlined),
      title: "Order",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,

    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      inactiveIcon:Icon(Icons.person_outline_outlined),
      title: "Account",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,

    ),

  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,


      backgroundColor: Theme.of(context).primaryColor,
      hideNavigationBar: _hideNavBar,
      decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .style1, // Choose the nav bar style with this property
    ),
  );
}