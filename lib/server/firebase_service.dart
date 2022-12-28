import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<void> addNewUser(User user) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");
    QuerySnapshot userSnapshot = await usersRef.get();
    bool oldUser = false;
    userSnapshot.docs.map((doc) {
      if (doc.id == user.uid) oldUser = true;
    }).toList();
    if (oldUser) return;
    await usersRef.doc(user.uid).set({
      'id': user.uid,
      'email': user.email,
      'displayName': user.displayName,
    });
    usersRef.doc(user.uid).collection("favorites").add({});
    usersRef.doc(user.uid).collection("follows").add({});

    print("ssaveledik useri ustam");
  }

  static Future<void> addFavorites(User user, String cryptoID) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");

    await usersRef.doc(user.uid).collection("favorites").doc(cryptoID).set({});
  }

  static Future<void> removeFavorites(User user, String cryptoID) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");

    await usersRef.doc(user.uid).collection("favorites").doc(cryptoID).delete();
  }

  static Future<List<String>> fetchFavorites(User user) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");
    QuerySnapshot query =
        await usersRef.doc(user.uid).collection("favorites").get();
    List<String> dizi = query.docs.map((e) => e.id).toList();
    print(dizi);
    return dizi;
  }
}
