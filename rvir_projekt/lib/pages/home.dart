import  'package:flutter/material.dart';
import '../widget/widget_support.dart';

class Home extends StatefulWidget {

  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home>{

  bool sweetFood=false, fastFood=false, healthyFood=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Hello Lejla", 
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
              Container(
                child: showItemsHorizontally(),
              ),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: showItemsVertically(context),
              )
              
              

              
              
              
          
      ],)
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
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: sweetFood? Colors.black : Colors.white, borderRadius: BorderRadius.circular(10)),
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
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: fastFood? Colors.black : Colors.white, borderRadius: BorderRadius.circular(10)),
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
                      setState(() {
                        
                      });
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child:Container(
                        decoration: BoxDecoration(color: healthyFood? Colors.black : Colors.white, borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Image.asset("images/salad-icon.png", height: 40, width: 40, fit: BoxFit.cover, color: healthyFood? Colors.white : Colors.black,),
                      )
                    ),
              )
                
              ],);
  }
}

Widget showItemsHorizontally(){
  return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/salad.jpg", height: 150, width: 150, fit: BoxFit.cover,),
                          Text("Veggie Salad", style: AppWidget.semiBoldTextFieldStyle(),),
                          SizedBox(height: 5.0,),
                          Text("Fresh and healthy", style: AppWidget.lightTextFieldStyle(),),
                          SizedBox(height: 5.0),
                          Text("\$10", style: AppWidget.semiBoldTextFieldStyle(),)
                      ],),
                  )
                  ),
                  SizedBox(width: 15.0,),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/salad.jpg", height: 150, width: 150, fit: BoxFit.cover,),
                          Text("Mixed Salad", style: AppWidget.semiBoldTextFieldStyle(),),
                          SizedBox(height: 5.0,),
                          Text("Very spicy", style: AppWidget.lightTextFieldStyle(),),
                          SizedBox(height: 5.0),
                          Text("\$14", style: AppWidget.semiBoldTextFieldStyle(),)
                      ],),
                  )
                  ),
                  
                ],
              ),
              );

}

Widget showItemsVertically(context){
  return Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/salad.jpg", 
                          height: 120, 
                          width: 120, 
                          fit:BoxFit.cover,),
                      SizedBox(width: 20.0,),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text("Mediteranian Salad", style: AppWidget.semiBoldTextFieldStyle(),),
                          ),
                          SizedBox(height: 5.0,),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text("Honey goat cheese", style: AppWidget.lightTextFieldStyle(),),
                          ),
                          SizedBox(height: 5.0,),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text("\$15", style: AppWidget.semiBoldTextFieldStyle(),),
                          ),
                          
                      ],
                    )

                  ],
                )
                

              ),
              );
}