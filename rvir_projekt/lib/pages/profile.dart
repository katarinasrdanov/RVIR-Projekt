import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [
      Stack(
        children: [
          Container(
              padding: EdgeInsets.only(top: 0.45, left: 20.2, right: 20.0),
              height: MediaQuery.of(context).size.height / 4.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0Xffff5722),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 90.0)),
              )),
          Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6.5),
                child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "images/boy.jpg",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )))),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Peter Klepec",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 40.0,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Peter Klepec",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ])
                      ],
                    )))),
      ),
      //novi kontejner za mail:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.phone_outlined, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Number",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "069564348",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ])
                      ],
                    )))),
      ),
      //novi kontejner za description:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.add_home_outlined, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Addresses",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ])
                      ],
                    )))),
      ),
      //za delete
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delete Account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ])
                      ],
                    )))),
      ),
      //za logout:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Log out",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              )
                            ])
                      ],
                    )))),
      ),
    ])));
  }
}
