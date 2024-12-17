import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/admin/adminHome.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class AdminLogin extends StatefulWidget{
  @override
  State<AdminLogin> createState() => _AdminLoginState();

}

class _AdminLoginState extends State<AdminLogin>{

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ]),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 110.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text("Here you can login as admin!", style: AppWidget.headlineTextFieldStyle(), textAlign: TextAlign.center,),
                    SizedBox(height: 30.0,),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: MediaQuery.of(context).size.height/2.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50.0,),
                            TextFormField(
                                controller: usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: AppWidget.lightTextFieldStyle(),
                                    prefixIcon: Icon(Icons.person_2_outlined)),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password!';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidget.lightTextFieldStyle(),
                                    prefixIcon: Icon(Icons.password_outlined)),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  loginAdmin();
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Color(0Xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Center(
                                        child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins1",
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    
  }

  loginAdmin(){
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
      FirebaseFirestore.instance.collection("admin").get().then((snapshot) {
        snapshot.docs.forEach((result){
          if(result.data()["username"] != username || result.data()["password"] != password){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Incorrect username or password.",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                )));
          }
          else{
            Route route = MaterialPageRoute(builder: (context) => AdminHome());
            Navigator.pushReplacement(context, route);
          }
        });
      });
    }
}

