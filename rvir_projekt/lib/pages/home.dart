import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widget/widget_support.dart';
import '../pages/details.dart';
import "../service/database.dart";

class Home extends StatefulWidget {

  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home>{

  bool sweetFood=false, fastFood=false, healthyFood=false;

  Stream? foodItemsStream;

  ontheload(String category) async{
    foodItemsStream = await DatabaseMethods().getFoodItems(category);
    setState(() {
      
    });
  }

  @override
  void initState() {
    ontheload("");
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                          color: Colors.white
                        ),
        padding: EdgeInsets.only(top:50.0, left: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Hello Lejla,", 
                style: AppWidget.boldTextFieldStyle(),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.shopping_cart, color: Colors.white,),
              )
                ]
              ),
              SizedBox(height: 20.0,),
              Text("What do you feel like eating today?", 
                style: AppWidget.headlineTextFieldStyle(),
                ),
                Text("We have some delicious food options for you", 
                style: AppWidget.lightTextFieldStyle(),
                
                ),
                SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: showCategories(),
                ),
                SizedBox(height: 20.0,),
                Column(
                  children: [
                    Text("Top picks lately", style: AppWidget.semiBoldTextFieldStyle(),),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 295,
                      child: showItemsHorizontally(context, foodItemsStream),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: showItemsVertically(context, foodItemsStream),
                )
                
                
          
                
                
                
            
                ],),
        )
      ,)
    );
  }

  Widget showCategories(){
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      sweetFood=true;
                      fastFood=false;
                      healthyFood=false;
                      ontheload("sweet food");
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: sweetFood? Color(0Xffff5722) : Colors.white, borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Image.asset("images/ice-cream-icon.png", height: 40, width: 40, fit: BoxFit.cover, color: sweetFood? Colors.white : Colors.black,),
                      )
                    ),
              ),
                GestureDetector(
                    onTap: (){
                      sweetFood=false;
                      fastFood=true;
                      healthyFood=false;
                      ontheload("fast food");
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: fastFood? Color(0Xffff5722) : Colors.white, borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Image.asset("images/burger-icon.png", height: 40, width: 40, fit: BoxFit.cover, color: fastFood? Colors.white : Colors.black,),
                      )
                    ),
              ),
                GestureDetector(
                    onTap: (){
                      sweetFood=false;
                      fastFood=false;
                      healthyFood=true;
                      ontheload("healthy food");
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: healthyFood? Color(0Xffff5722) : Colors.white, borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Image.asset("images/salad-icon.png", height: 40, width: 40, fit: BoxFit.cover, color: healthyFood? Colors.white : Colors.black,),
                      )
                    ),
              )
                
              ],);
  }
}

Widget showItemsHorizontally(context, foodItemsStream) {

    return StreamBuilder(stream: foodItemsStream, builder: (context, AsyncSnapshot snapshot){
        return snapshot.hasData? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 242, 222),
                              borderRadius: BorderRadius.circular(20),
                            ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Details(ds)));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(14),
                            
                            child: Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset("images/burger.jpg", height: 150, width: 150, fit: BoxFit.cover,)),
                                  Text(ds["name"], style: AppWidget.semiBoldTextFieldStyle(),),
                                  SizedBox(height: 5.0,),
                                  Text(ds["shortDescr"], style: AppWidget.lightTextFieldStyle(),),
                                  SizedBox(height: 5.0),
                                  RatingBarIndicator(
                                      rating: ds["avgRating"].toDouble(),
                                      itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      direction: Axis.horizontal,
                                  ),
                                  Text("\$"+ds["price"].toString(), style: AppWidget.semiBoldTextFieldStyle(),)
                              ],),
                            ),
                                            ),
                        ),
                      ),
                      SizedBox(width: 20.0,)
                  ],
                );
              
        }):CircularProgressIndicator();
    });
  }


Widget showItemsVertically(context, foodItemsStream) {
  return StreamBuilder(stream: foodItemsStream, builder: (context, AsyncSnapshot snapshot){
        return snapshot.hasData? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(ds)));
                      },
                      child: Container(
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
                                child: Image.asset("images/burger.jpg", 
                                    height: 120, 
                                    width: 120, 
                                    fit:BoxFit.cover,),
                              ),
                              SizedBox(width: 20.0,),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: Text(ds["name"], style: AppWidget.semiBoldTextFieldStyle(),),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: Text(ds["shortDescr"], style: AppWidget.lightTextFieldStyle(),),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: Text("\$"+ds["price"].toString(), style: AppWidget.semiBoldTextFieldStyle(),),
                                  ),
                                  
                              ],
                            )
                        
                          ],
                        )
                        
                        
                      ),
                    ),
                    SizedBox(height: 15.0,)
                  ],
                );
              
        }):CircularProgressIndicator();
    });
}
