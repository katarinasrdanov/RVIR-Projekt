import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rvir_projekt/pages/bottomnav.dart';
import 'package:rvir_projekt/pages/login.dart';
import 'package:rvir_projekt/service/database.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name = "", email = "", password = "", phone = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');

  registration() async {
    if (password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            ))));

        // uzmemo uid
        User? user = userCredential.user;
        if (user != null) {
          String uid = user.uid;

          Map<String, dynamic> addUserInfo = {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "wallet": "0"
          };

          // sad je UID umjesto generated alphaNum
          await DatabaseMethods().addUserDetail(addUserInfo, uid);

          //pushReplacement umesto push da se ne moze vratit nazad
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        }
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password is too weak",
                style: TextStyle(fontSize: 18.0),
              ))));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account already exists",
                style: TextStyle(fontSize: 18.0),
              ))));
        }
      }
    }
  }

  bool validateEmailAndPhone() {
    if (!emailRegex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Invalid email format!",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ));
      return false;
    }
    if (!phoneRegex.hasMatch(phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Phone number can only contain numbers!",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(top: 1, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "images/FoodieLogo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    )),
                    SizedBox(
                      height: 0.5,
                    ),
                    Material(
                      elevation: 6.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Sign up",
                                style: AppWidget.headlineTextFieldStyle(),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: AppWidget.lightTextFieldStyle(),
                                    prefixIcon: Icon(Icons.person_outlined)),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your e-mail.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: AppWidget.lightTextFieldStyle(),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password.';
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
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Phone number',
                                    hintStyle: AppWidget.lightTextFieldStyle(),
                                    prefixIcon: Icon(Icons.phone_outlined)),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    if (validateEmailAndPhone()) {
                                      setState(() {
                                        email = emailController.text;
                                        name = nameController.text;
                                        password = passwordController.text;
                                        phone = phoneController.text;
                                      });
                                      await registration();
                                    }
                                  }
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
                                      "SIGN UP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins1",
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogIn()));
                                },
                                child: Text("Already have an account? Log In!",
                                    style: AppWidget.lightTextFieldStyle()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
