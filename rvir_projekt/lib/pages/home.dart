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
        margin: EdgeInsets.only(top:50.0, left: 20.0, right: 10.0),
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
              showItem(),
              
          
      ],)
      ,)
    );
  }

  Widget showItem(){
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