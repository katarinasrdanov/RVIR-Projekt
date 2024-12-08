import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //preverja ce je user autentikovan ali ne
  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //brisanje podatkov o useru iz baze onda iz authentikacije
  Future<void> deleteUser() async {
    try {
      // auth usera
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // UID
        String userId = user.uid;
        // Iz baze
        var userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        await userDocRef.delete();

        // iz auth
        await user.delete();
      }
    } catch (e) {
      throw Exception("Failed to delete user.");
    }
  }
}
