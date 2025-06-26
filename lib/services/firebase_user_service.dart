import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class FirebaseUserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update user profile in Firebase Auth and Firestore
  static Future<void> updateUserProfile({
    required String userId,
    String? name,
    String? email,
    File? imageFile,
  }) async {
    try {
      // Update Firebase Auth if email changed
      if (email != null && email != _auth.currentUser?.email) {
        await _auth.currentUser?.verifyBeforeUpdateEmail(email);
      }

      // Update Firestore user document
      final userRef = _firestore.collection('users').doc(userId);
      final updateData = <String, dynamic>{};

      if (name != null) updateData['username'] = name;
      if (email != null) updateData['email'] = email;

      if (updateData.isNotEmpty) {
        await userRef.update(updateData);
      }

      // Update local auth user if name changed
      if (name != null) {
        await _auth.currentUser?.updateDisplayName(name);
      }
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

}