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

  Future addUserDetail(Map<String, dynamic> userInfoMap, String uid) async {
    return await firestore.collection('users').doc(uid).set(userInfoMap);
  }

  Future<void> addAddress(
      String email, Map<String, dynamic> addressInfo) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String uid = querySnapshot.docs.first.id;

        CollectionReference addressesRef =
            firestore.collection('users').doc(uid).collection('addresses');
        await addressesRef.add(addressInfo);
      }
    } catch (e) {
      print("Error adding address: $e");
    }
  }
}
