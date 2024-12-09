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

  Future<List<Map<String, dynamic>>> getUserAddresses(String email) async {
    List<Map<String, dynamic>> addresses = [];

    try {
      QuerySnapshot userQuerySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        String uid = userQuerySnapshot.docs.first.id;

        QuerySnapshot addressQuerySnapshot = await firestore
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .get();

        for (var doc in addressQuerySnapshot.docs) {
          Map<String, dynamic> addressData = doc.data() as Map<String, dynamic>;
          addressData['id'] = doc.id;
          addresses.add(addressData);
        }
      }

      return addresses;
    } catch (e) {
      print("Error fetching addresses: $e");
      return [];
    }
  }

  Future<void> deleteAddress(String email, String addressId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String uid = querySnapshot.docs.first.id;

        DocumentReference addressRef = firestore
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .doc(addressId);

        await addressRef.delete();
      }
    } catch (e) {
      print("Error deleting address: $e");
    }
  }
}
