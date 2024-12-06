import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //function that gets food items based on category (all food items if no category is selected)
  Future<Stream<QuerySnapshot>> getFoodItems(String category) async {
    if (category.isNotEmpty) {
      return firestore
          .collection("food")
          .where("category", isEqualTo: category)
          .snapshots();
    }
    return firestore.collection("food").snapshots();
  }

  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await firestore.collection('users').doc(id).set(userInfoMap);
  }
}
