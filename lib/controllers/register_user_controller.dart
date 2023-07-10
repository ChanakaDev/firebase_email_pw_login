import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RegisterUserController extends GetxController {
  // Firebase - Write Data
  // Dynamic document

  // Named arguments in flutter methods
  void writeUserDataInFirebase({
    required String userEmail,
    required String userPassword,
    required String userName,
    required String userPhone,
    required String userALStream,
    required String userDistrict,
  }) {
    // Firebase firestore instance
    final db = FirebaseFirestore.instance;
    // Write data to a collection
    db.collection('users').add({
      'email': userEmail,
      'password': userPassword,
      'name': userName,
      'phone': userPhone,
      'al_stream': userALStream,
      'district': userDistrict,
    });
  }
}