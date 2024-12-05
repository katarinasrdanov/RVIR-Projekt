import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/pages/order.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/wallet.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() =>  _BottomNavState();


}

class _BottomNavState extends State<BottomNav>{
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Profile profilePage;
  late Wallet walletPage;
  late Order orderPage;

  @override
  void initState() {
    homePage = Home();
    orderPage = Order();
    profilePage = Profile();
    walletPage = Wallet();
    pages = [homePage, orderPage, profilePage, walletPage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Color(0xFFff5c30),
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
        Icon(Icons.home_outlined, color: Colors.white,),
        Icon(Icons.shopping_bag_outlined, color: Colors.white,),
        Icon(Icons.wallet_outlined, color: Colors.white,),
        Icon(Icons.person_outline, color: Colors.white,),
        ]),
        body: pages[currentTabIndex],
    );
  }
}