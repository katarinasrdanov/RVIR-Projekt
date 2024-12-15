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

  //function that gets up to top 5 food items based on average rating
  Future<Stream<QuerySnapshot>> getTopRatedFoodItems(String category) async {
    Query query = firestore
        .collection("food")
        .orderBy("avgRating", descending: true)
        .limit(5);
    return query.snapshots();
  }

  Future addUserDetail(Map<String, dynamic> userInfoMap, String uid) async {
    return await firestore.collection('users').doc(uid).set(userInfoMap);
  }

  // funkcije za pridobitev celotnega user-a

  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print("User document does not exist!");
        return null;
      }
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }

  Future<void> updateWallet(String uid, int newBalance) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'wallet': newBalance});
    } catch (e) {
      print("Error updating wallet: $e");
    }
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

  Future<void> saveRating(double rating, foodItemId) async {
    try {
      // Reference to the food item document
      DocumentReference foodDocRef =
          FirebaseFirestore.instance.collection('food').doc(foodItemId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the rated food item document
        DocumentSnapshot snapshot = await transaction.get(foodDocRef);

        if (!snapshot.exists) {
          throw Exception("Food item does not exist");
        }

        // Cast snapshot data to a map
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        // Retrieve and update ratings
        List<dynamic> ratings = data['ratings'] ?? [];

        ratings.add(rating);

        // Calculate the new average rating
        double sum = 0;
        for (int i = 0; i < ratings.length; i++) {
          sum += ratings[i];
        }
        double avgRating = sum / ratings.length as double;

        // Update the document
        transaction.update(foodDocRef, {
          'ratings': ratings,
          'avgRating': avgRating,
        });
      });
    } catch (err) {
      print("Error in saveRating: $err");
    }
  }

  Future addItemToCart(Map<String, dynamic> userInfoMap, String uid) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('order')
        .add(userInfoMap);
  }
}
