// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopnewversion/models/registermodel/registermodel.dart';
import 'package:shopnewversion/views/homepageViews/homepage_view.dart';
import 'package:shopnewversion/views/registerviews/register_with_facebook_or_google_view.dart';

import '../models/Usermodel.dart';

class LoginController {
final UserModel user = UserModel(username: '', password: '');

  
  void updateUsername(String username) {
    user.username = username;
  }

  void updatePassword(String password) {
    user.password = password;
  }

  //connexion with email and password
  Future<void> login(BuildContext context) async {
   // await SignInWithEmailAndPassword(user.username, user.password);
    try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.username,
      password: user.password,
    );
    // Connexion successful or not
    print("Connecté: ${userCredential.user!.email}");
    final querySnapshot = await   FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get();
    final UserRegister userRegister = UserRegister.fromDocument(querySnapshot);
     Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => HomePage(storeName: userRegister.enterpriseName )),
      );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('Aucun utilisateur trouvé pour cet email.');
    } else if (e.code == 'wrong-password') {
      print('Mot de passe incorrect.');
    }
  } catch (e) {
    print(e);
  }
  }

  // Connexion whith Google
  Future<void> loginWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
         print('logingoogleOkay!');
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential=   await FirebaseAuth.instance.signInWithCredential(credential);

        print('success!');
         User? userC =userCredential.user;
        bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
        updateUsername(userC?.email??'');
// if his userDoc alredy exist
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userC?.uid).get();

      if (isNewUser || !userDoc.exists) {
        print('not register yet!');
  // registerwith Faceb or Goog
           Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => RegisterWithFacebookOrGoogle(email:user.username , uid:userC?.uid??'')),
      );
         } else {
  // homepage redirection
        final querySnapshot = await   FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get();
        final UserRegister userRegister = UserRegister.fromDocument(querySnapshot);
     Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => HomePage(storeName: userRegister.enterpriseName )),
      );
      //  Navigator.pushNamed(context, '/homepage');
      }

        
        print('success!');

      } else {
        // Gestion des erreurs ou annulation de la connexion
        print('fail');
      }
      
    } catch (e) {
      print('Erreur de connexion avec Google: $e');
      print('fail');
    }
  }

    // Connexion with facebook
  Future<void> loginWithFaceBook(BuildContext context) async {
    final FacebookAuth _facebookAuth = FacebookAuth.instance;
    try {
      final result = await _facebookAuth.login();
      print('loginfacebookOkay!');
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
        User? userC =userCredential.user;
        bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
        updateUsername(userC?.email??'');
// if his userDoc alredy exist
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userC?.uid).get();

      if (isNewUser || !userDoc.exists) {
        print('not register yet!');
  // registerwith Faceb or Goog
           Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => RegisterWithFacebookOrGoogle(email:user.username , uid:userC?.uid??'')),
      );
         } else {
  // homepage redirection
        final querySnapshot = await   FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get();
        final UserRegister userRegister = UserRegister.fromDocument(querySnapshot);
     Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => HomePage(storeName: userRegister.enterpriseName )),
      );
      //  Navigator.pushNamed(context, '/homepage');
      }

        
        print('success!');

      } else {
        // Gestion des erreurs ou annulation de la connexion
        print('fail');
      }
    } catch (e) {
      // Gestion des exceptions
    }

  }
}