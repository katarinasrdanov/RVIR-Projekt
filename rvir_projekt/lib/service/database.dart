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

  Future<void> updateWallet(String uid, String newBalance) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'wallet': newBalance});
    } catch (e) {
      print("Error updating wallet: $e");
    }
  }

  Future<void> addAddress(String uid, Map<String, dynamic> addressInfo) async {
    try {
      CollectionReference addressesRef =
          firestore.collection('users').doc(uid).collection('addresses');
      await addressesRef.add(addressInfo);
    } catch (e) {
      print('Failed to add address: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUserAddresses(String uid) async {
    try {
      List<Map<String, dynamic>> addresses = [];
      QuerySnapshot addressQuerySnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .get();

      if (addressQuerySnapshot.docs.isNotEmpty) {
        for (var doc in addressQuerySnapshot.docs) {
          Map<String, dynamic> addressData = doc.data() as Map<String, dynamic>;
          addressData['id'] = doc.id;
          addresses.add(addressData);
        }
      }
      return addresses;
    } catch (e) {
      print('Failed to get addresses: $e');
      rethrow;
    }
  }

  Future<void> deleteAddress(String uid, String addressId) async {
    try {
      DocumentReference addressRef = firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .doc(addressId);

      await addressRef.delete();
    } catch (e) {
      print('Failed to delete address: $e');
      rethrow;
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

  Future<Stream<QuerySnapshot>> getFoodCart(String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("order")
        .snapshots();
  }

  Future<void> deleteUserOrderCollection(String uid) async {
    try {
      CollectionReference orderCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('order');

      QuerySnapshot orderSnapshot = await orderCollection.get();
      for (QueryDocumentSnapshot doc in orderSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("Error deleting order collection: $e");
    }
  }

  Future<void> deleteFoodItem(String id) async {
    try {
      DocumentReference foodItemRef = firestore.collection('food').doc(id);

      await foodItemRef.delete();
    } catch (err) {
      print("Error deleting order collection: $err");
    }
  }

  Future<void> addFoodItem(Map<String, dynamic> itemToAdd) async {
    try {
      CollectionReference foodRef = firestore.collection('food');
      await foodRef.add(itemToAdd);
    } catch (e) {
      print('Failed to add food item: $e');
      rethrow;
    }
  }

  //edit
  Future<void> updateFoodItem(
      String docId, Map<String, dynamic> updatedData) async {
    return await FirebaseFirestore.instance
        .collection("food")
        .doc(docId)
        .update(updatedData);
  }
}
