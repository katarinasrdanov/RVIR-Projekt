import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class Details extends StatefulWidget{

  final DocumentSnapshot<Object?> foodItem; // Accept foodItem as a parameter

  const Details(this.foodItem, {super.key}); // Assign the passed document to the widget

  @override
  State<StatefulWidget> createState() => _DetailsState();

}

class _DetailsState extends State<Details>{
  int numToOrder = 1;
  
  _DetailsState();


  @override
  Widget build(BuildContext context) {
    final foodItem = widget.foodItem;

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
                          color: Colors.white
                        ),
          padding: EdgeInsets.only(top: 50.0, left:20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.black,),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("images/salad.jpg", 
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/2.5, 
                              fit: BoxFit.cover,),
              ),
              SizedBox(height: 15.0,),
              
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // Item details (name and description)
    Expanded( // Ensures the text wraps or shrinks to fit available space
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            foodItem["name"],
            style: AppWidget.semiBoldTextFieldStyle(),
            overflow: TextOverflow.ellipsis, // Avoids text overflow
          ),
          SizedBox(height: 5.0),
          Text(
            foodItem["shortDescr"],
            style: AppWidget.headlineTextFieldStyle(),
            maxLines: 2, // Limits to 2 lines to prevent overflow
            overflow: TextOverflow.ellipsis, // Trims text if it exceeds
          ),
        ],
      ),
    ),
    // Quantity controls
    Row(
      children: [
        // Decrement button
        GestureDetector(
          onTap: () {
            if (numToOrder > 1) {
              --numToOrder;
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.remove, color: Colors.white),
          ),
        ),
        SizedBox(width: 15.0),
        // Quantity number
        Text(
          numToOrder.toString(),
          style: AppWidget.semiBoldTextFieldStyle(),
        ),
        SizedBox(width: 15.0),
        // Increment button
        GestureDetector(
          onTap: () {
            ++numToOrder;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    ),
  ],
),
              SizedBox(height: 20.0,),
              Text(foodItem["longDescr"], style: AppWidget.lightTextFieldStyle(), maxLines: 3,),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text("Delivery Time", style: AppWidget.lightTextFieldStyle(),),
                  SizedBox(width: 5.0,),
                  Icon(Icons.alarm),
                  SizedBox(width: 5.0,),
                  Text(foodItem["deliveryTime"].toString()+" min", style: AppWidget.semiBoldTextFieldStyle(),)
                ],
              ),
              Spacer(),
              Padding(padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 242, 222),
                    
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: AppWidget.semiBoldTextFieldStyle(),),
                      Text("\$"+foodItem["price"].toString(), style: AppWidget.headlineTextFieldStyle(),)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    Text("Add to cart", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 16.0),),
                    SizedBox(width: 30.0,),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                    ),
                    SizedBox(width: 10.0,)
                  ],),
                )
              ],),
              
              )
              
            ],

          ),
        )
    );
  }

}