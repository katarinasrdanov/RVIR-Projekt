import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/service/database.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? userUid, wallet;

  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(Duration(milliseconds: 400), () {
      amount2 = total;
      setState(() {});
    });
  }

  getUID() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    userUid = currentUser?.uid;
    setState(() {});
  }

  Future<void> fetchWallet(String uid) async {
    try {
      Map<String, dynamic>? userDetails =
          await DatabaseMethods().getUserDetails(uid);
      if (userDetails != null) {
        wallet = userDetails['wallet'];
      }
    } catch (e) {
      print('Error fetching wallet: $e');
    }
  }

  ontheload() async {
    await getUID();
    await fetchWallet(userUid!);
    foodStream = await DatabaseMethods().getFoodCart(userUid!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["total"]);
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 242, 222),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(child: Text(ds["quantity"])),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.network(ds["image"],
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover)),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        ds["name"],
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                    ),
                                    Text(
                                      "\€" + ds["total"],
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(top: 0.45, left: 20.2, right: 20.0),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0Xffff5722),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 90.0)),
                ),
                child: Center(
                    child: Text(
                  "Food Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ))),
            SizedBox(
              height: 20.0,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text("\€" + total.toString(),
                      style: AppWidget.semiBoldTextFieldStyle())
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                if (amount2 < int.parse(wallet!)) {
                  int amount = int.parse(wallet!) - amount2;
                  await DatabaseMethods()
                      .updateWallet(userUid!, amount.toString());
                  await DatabaseMethods().deleteUserOrderCollection(userUid!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Order placed successfully!",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Insufficient amount in the wallet!",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ));
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0Xffff5722),
                      borderRadius: BorderRadius.circular(10)),
                  margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
