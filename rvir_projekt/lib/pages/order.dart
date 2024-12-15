import 'package:flutter/material.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text("2")),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset("images/salad.jpg",
                                height: 90, width: 90, fit: BoxFit.cover)),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "Pizza",
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                            Text(
                              "\$40",
                              style: AppWidget.semiBoldTextFieldStyle(),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
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
                  Text("\$50.0", style: AppWidget.semiBoldTextFieldStyle())
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0Xffff5722),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
