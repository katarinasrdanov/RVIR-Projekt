import 'dart:io';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rvir_projekt/pages/login.dart';
import 'package:rvir_projekt/pages/signup.dart';
import 'package:rvir_projekt/service/auth.dart';
import 'package:rvir_projekt/service/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email, number;

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {});
    }
  }

  getthesharedpref() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    number = await SharedPreferenceHelper().getUserPhone();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  void logoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: const Color.fromARGB(255, 255, 242, 222),
          title: const Text(
            "Log Out",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0Xffff5722),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child:
                  const Text("Log Out", style: TextStyle(color: Colors.white)),
              onPressed: () {
                AuthMethods().SignOut();
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              },
            ),
          ],
        );
      },
    );
  }

  void deleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: const Color.fromARGB(255, 255, 242, 222),
          title: const Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: const Text(
            "Are you sure you want to delete your account?",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0Xffff5722),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
              onPressed: () {
                AuthMethods().deleteUser();
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
            ),
          ],
        );
      },
    );
  }

  void showAddresses(BuildContext context, List<String> addresses) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Addresses'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: addresses.map((address) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            child: const Text('Edit'),
                            onPressed: () {
                              //fali funkcija
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              //fja deleteAddress();
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                showAddAddress(context);
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showAddAddress(BuildContext context) {
    final TextEditingController streetController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
              TextField(
                controller: zipCodeController,
                decoration: InputDecoration(labelText: 'Zip Code'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                //fja fali
                Navigator.of(context).pop(); // Close the dialog after saving
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//ko uploadam sliko s telefona se bo dodala v firebase (profilna)
  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: name == null
            ? CircularProgressIndicator()
            : Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: 0.45, left: 20.2, right: 20.0),
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
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: Stack(
                                  children: [
                                    selectedImage == null
                                        ? profile == null
                                            ? Image.asset(
                                                "images/boy.jpg",
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                profile!,
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              )
                                        : Image.file(
                                            selectedImage!,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                    if (selectedImage == null)
                                      Positioned(
                                        bottom: 40,
                                        right: 45,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: const Color(0Xffff5722),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 70.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name!,
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
                                    color: Color.fromARGB(255, 255, 242, 222),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline,
                                        color: Colors.black),
                                    SizedBox(width: 20.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            email!,
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
                                    color: Color.fromARGB(255, 255, 242, 222),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(Icons.phone_outlined,
                                        color: Colors.black),
                                    SizedBox(width: 20.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Phone number",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            number!,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ])
                                  ],
                                )))),
                  ),
                  //novi kontejner za addresses:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        List<String> addresses = [
                          'Vodnikov trg 6, 2000 Maribor',
                          'Dravska 7, 2000 Maribor',
                          'Koroska cesta 46, 2000 Maribor'
                        ];
                        showAddresses(context, addresses);
                      },
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
                                      color: Color.fromARGB(255, 255, 242, 222),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_home_outlined,
                                          color: Colors.black),
                                      SizedBox(width: 20.0),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Addresses",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ])
                                    ],
                                  )))),
                    ),
                  ),
                  //za delete
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        deleteConfirmation(context);
                      },
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
                                      color: Color.fromARGB(255, 255, 242, 222),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline,
                                          color: Colors.black),
                                      SizedBox(width: 20.0),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delete Account",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ])
                                    ],
                                  )))),
                    ),
                  ),
                  //za logout:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        logoutConfirmation(context);
                      },
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
                                      color: Color.fromARGB(255, 255, 242, 222),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout_outlined,
                                          color: Colors.black),
                                      SizedBox(width: 20.0),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Log out",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ])
                                    ],
                                  )))),
                    ),
                  ),
                ])));
  }
}
