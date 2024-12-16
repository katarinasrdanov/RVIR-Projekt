import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/admin/addFoodItem.dart';
import 'package:rvir_projekt/service/database.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}



class _AdminHomeState extends State<AdminHome> {
  Stream? allFoodItemsStream;

  ontheload() async {
    allFoodItemsStream = await DatabaseMethods().getFoodItems("");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Admin Panel", style: AppWidget.headlineTextFieldStyle(),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: showItemsVertically(context, allFoodItemsStream),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFoodItem(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Food Item',
      ),
    );
  }
Widget showItemsVertically(context, foodItemsStream) {
  return StreamBuilder(
      stream: foodItemsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 242, 222),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Section
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                ds["image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            // Details Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Food Name
                                  Text(
                                    ds["name"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5.0),
                                  // Short Description
                                  Text(
                                    ds["shortDescr"],
                                    style: AppWidget.lightTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5.0),
                                  // Price
                                  Text(
                                    "\€" + ds["price"].toString(),
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ),
                            // Edit and Delete Icons
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Delete action - To be implemented
                                  },
                                  icon: Icon(Icons.delete, size: 18, color: Colors.grey),
                                  tooltip: 'Delete Item',
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                                SizedBox(height: 8.0), // Spacing between icons
                                IconButton(
                                  onPressed: () {
                                    // Edit action - To be implemented
                                  },
                                  icon: Icon(Icons.edit_document, size: 18, color: Colors.grey),
                                  tooltip: 'Edit Item',
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                                
                                
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                    ],
                  );
                },
              )
            : CircularProgressIndicator();
      });
}



}