import 'package:flutter/material.dart';
import 'package:rvir_projekt/widget/widget_support.dart';

class AddFoodItem extends StatefulWidget {
  const AddFoodItem({super.key});

  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController deliveryTimeController = new TextEditingController();
  TextEditingController shortDescrController = new TextEditingController();
  TextEditingController longDescrController= new TextEditingController();
  //TextEditingController categoryController = new TextEditingController();
  String? categoryValue;
  final List<String> categories = ["fast food", "healthy food", "sweet food"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Food Item", style: AppWidget.headlineTextFieldStyle(),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload Image", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20.0,),
              Center(
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5), 
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
        
              //Item name
              Text(
                "Name:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
        
              //Item price
              Text(
                "Price:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              //Item category
              Text(
                "Category:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String> (
                    items: categories.map((item) => DropdownMenuItem<String>(
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
                    hint: Text("Select Category", style: AppWidget.lightTextFieldStyle(),),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                    value: categoryValue,
                    )
                ),
              ),
              SizedBox(height: 20.0),

        
              //Item delivery time
              Text(
                "Delivery Time:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: deliveryTimeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Delivery Time",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
        
              //Item short description
              Text(
                "Short Description:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: shortDescrController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Short Description",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
        
              //Item long description
              Text(
                "Long Description:", style: AppWidget.semiBoldTextFieldStyle(),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 222),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  maxLines: 6,
                  controller: longDescrController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Long Description",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              //add item button
              GestureDetector(
                onTap: (){
                  //uploadItem();
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
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}