import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile
      await userCredential.user?.updateDisplayName(displayName);

      // Store additional user data in Firestore
      if (userCredential.user != null) {
        await _storeUserData(userCredential.user!, displayName);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign up error: ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Unexpected error during sign up: $e');
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last sign in time
      if (userCredential.user != null) {
        await _updateLastSignIn(userCredential.user!);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign in error: ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Unexpected error during sign in: $e');
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Sign out error: $e');
      throw 'Failed to sign out. Please try again.';
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint('Password reset error: ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Unexpected error during password reset: $e');
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Store user data in Firestore
  Future<void> _storeUserData(User user, String displayName) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'lastSignIn': FieldValue.serverTimestamp(),
        'isOnline': true,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error storing user data: $e');
    }
  }

  // Update last sign in time
  Future<void> _updateLastSignIn(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'lastSignIn': FieldValue.serverTimestamp(),
        'isOnline': true,
      });
    } catch (e) {
      debugPrint('Error updating last sign in: $e');
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user data: $e');
      return null;
    }
  }

  // Update user online status
  Future<void> updateOnlineStatus(bool isOnline) async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'isOnline': isOnline,
          'lastSeen': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        debugPrint('Error updating online status: $e');
      }
    }
  }

  // Get all users (for video calling)
  Stream<QuerySnapshot> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('lastSignIn', descending: true)
        .snapshots();
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }
}