//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:random_string/random_string.dart';
import 'package:rvir_projekt/service/shared_pref.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email, number;

  /*final ImagePicker _picker = ImagePicker();
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
  }*/

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

//ko uploadam sliko s telefona se bo dodala v firebase (profilna)
  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: name == null? CircularProgressIndicator(): Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(children: [
              Stack(
                children: [
                  Container(
                      padding:
                          EdgeInsets.only(top: 0.45, left: 20.2, right: 20.0),
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
                                child: selectedImage  == null?  
                                GestureDetector(
                                  onTap: (){
                                    getImage();
                                  },
                                  child: profile==null? Image.asset("images/boy.jpg", height: 120, width: 120, fit: BoxFit.cover) : Image.network(
                                    profile!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ): Image.file(selectedImage!),
                                ),),),
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
                                Icon(Icons.person_outline, color: Colors.black),
                                SizedBox(width: 20.0),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                Icon(Icons.phone_outlined, color: Colors.black),
                                SizedBox(width: 20.0),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Phone number",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                color: Color.fromARGB(255, 255, 242, 222),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline, color: Colors.black),
                                SizedBox(width: 20.0),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
