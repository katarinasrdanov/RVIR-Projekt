import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:rvir_projekt/service/database.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class AddFoodItem extends StatefulWidget {
  final DocumentSnapshot? foodItem;
  const AddFoodItem({super.key, this.foodItem});

  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController deliveryTimeController = new TextEditingController();
  TextEditingController shortDescrController = new TextEditingController();
  TextEditingController longDescrController = new TextEditingController();

  String? categoryValue;
  final List<String> categories = ["fast food", "healthy food", "sweet food"];

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    if (widget.foodItem != null) {
      nameController.text = widget.foodItem!["name"];
      priceController.text = widget.foodItem!["price"].toString();
      deliveryTimeController.text = widget.foodItem!["deliveryTime"].toString();
      shortDescrController.text = widget.foodItem!["shortDescr"];
      longDescrController.text = widget.foodItem!["longDescr"];
      categoryValue = widget.foodItem!["category"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        centerTitle: true,
        title: Text("Add Food Item", style: AppWidget.headlineTextFieldStyle(),),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            (widget.foodItem != null) ? Text("Edit Food Item", style: AppWidget.headlineTextFieldStyle(),) : Text("Add Food Item", style: AppWidget.headlineTextFieldStyle(),),
            SizedBox(height: 20,),
            Container(
              margin:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Image",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  selectedImage == null
                      ? GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Material(
                              color: Colors.white,
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Material(
                            color: Colors.white,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
            
                  //Item name
                  Text(
                    "Name:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Item Name",
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
            
                  //Item price
                  Text(
                    "Price:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Item Price",
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
            
                  //Item category
                  Text(
                    "Category:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      items: categories
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style:
                                    TextStyle(fontSize: 18.0, color: Colors.black),
                              )))
                          .toList(),
                      onChanged: ((value) => {
                            setState(() {
                              this.categoryValue = value;
                            })
                          }),
                      dropdownColor: Color.fromARGB(255, 255, 242, 222),
                      hint: Text(
                        "Select Category",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: categoryValue,
                    )),
                  ),
                  SizedBox(height: 20.0),
            
                  //Item delivery time
                  Text(
                    "Delivery Time:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: deliveryTimeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Item Delivery Time",
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
            
                  //Item short description
                  Text(
                    "Short Description:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: shortDescrController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Short Description",
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
            
                  //Item long description
                  Text(
                    "Long Description:",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 242, 222),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      maxLines: 6,
                      controller: longDescrController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Long Description",
                          hintStyle: AppWidget.lightTextFieldStyle()),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //add item button
                  GestureDetector(
                    onTap: () {
                      uploadItem();
                    },
                    child: Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0Xffff5722),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: (widget.foodItem != null) ? Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ) : Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold))
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null ||
        widget.foodItem != null &&
            nameController.text.isNotEmpty &&
            priceController.text.isNotEmpty &&
            longDescrController.text.isNotEmpty &&
            deliveryTimeController.text.isNotEmpty &&
            shortDescrController.text.isNotEmpty) {
      String downloadUrl =
          widget.foodItem != null ? widget.foodItem!["image"] : "";

      try {
        if (selectedImage != null) {
          String addId = widget.foodItem != null
              ? widget.foodItem!.id
              : randomAlphaNumeric(10);

          Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child("foodImages").child(addId);
          UploadTask task = firebaseStorageRef.putFile(selectedImage!);
          downloadUrl = await (await task).ref.getDownloadURL();
        }

        Map<String, dynamic> itemToAdd = {
          "image": downloadUrl,
          "name": nameController.text,
          "price": int.parse(priceController.text),
          "deliveryTime": int.parse(deliveryTimeController.text),
          "shortDescr": shortDescrController.text,
          "longDescr": longDescrController.text,
          "category": categoryValue,
          "avgRating":
              widget.foodItem != null ? widget.foodItem!["avgRating"] : 0
        };

        if (widget.foodItem != null) {
          await DatabaseMethods().updateFoodItem(widget.foodItem!.id, itemToAdd);
        } else {
          await DatabaseMethods().addFoodItem(itemToAdd);
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            widget.foodItem != null
                ? "Food Item Updated Successfully"
                : "Food Item Added Successfully",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ));

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Error saving the item!",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Please fill all fields and select a category!",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ));
    }
  }
}
