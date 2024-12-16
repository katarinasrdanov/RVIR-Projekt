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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  ds["image"],
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["name"],
                                      style:
                                          AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["shortDescr"],
                                      style: AppWidget.lightTextFieldStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\€" + ds["price"].toString(),
                                      style:
                                          AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: 15.0,
                      )
                    ],
                  );
                })
            : CircularProgressIndicator();
      });
}

}