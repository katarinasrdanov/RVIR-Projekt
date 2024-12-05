import 'package:flutter/material.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                          color: Colors.white
                        ),
        //margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.45, left: 20.2, right: 20.0),
              height: MediaQuery.of(context).size.height / 4.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0Xffff5722),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 90.0)),
              ),
              child: Center(
                child: Text("Wallet", 
                            style: TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),)
                ),
                
            ),
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 242, 222),
                borderRadius: BorderRadius.circular(8),
                ),
              child: Row(
                children: [
                  Image.asset("images/wallet-icon.png", 
                            height: 60, width: 60, fit: BoxFit.cover,),
                  SizedBox(width: 40.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your balance", style: AppWidget.lightTextFieldStyle(),),
                      SizedBox(height: 20.0,),
                      Text("\$"+"100", style: AppWidget.boldTextFieldStyle(),)
                    ],
                  )
                  



                ],

              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Add money", style: AppWidget.semiBoldTextFieldStyle(),),
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              addMoneyContainer(100),
              addMoneyContainer(200),
              addMoneyContainer(500),
              addMoneyContainer(1000)
            ],),
            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 50, 172, 86),
                borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text("Add Money", style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),),

                ),
            )
          ],
        ),
      ),
    );

  }
  
}

Widget addMoneyContainer(money){
  return Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 242, 222),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("\$"+money.toString(), style: AppWidget.semiBoldTextFieldStyle(),),
              );
}