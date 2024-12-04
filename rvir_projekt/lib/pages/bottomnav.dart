import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
//import '../pages/wallet.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() =>  _BottomNavState();


}

class _BottomNavState extends State<BottomNav>{
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Profile prifilePage;
  //late Wallet walletPage;
  //late Order orderPage;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}