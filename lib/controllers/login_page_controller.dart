// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/Usermodel.dart';

class LoginController {
final UserModel user = UserModel(username: '', password: '');

  // Méthode pour mettre à jour le modèle
  void updateUsername(String username) {
    user.username = username;
  }

  void updatePassword(String password) {
    user.password = password;
  }

  //connexion with email and password
  Future<void> login() async {
   // await SignInWithEmailAndPassword(user.username, user.password);
    try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.username,
      password: user.password,
    );
    // Connexion successful or not
    print("Connecté: ${userCredential.user!.email}");
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
         print('loginfacebookOkay!');
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        print('success!');
      }
    } catch (e) {
      print('Erreur de connexion avec Google: $e');
      print('fail');
    }
   /* UserCredential? us = await signInWithGoogle(context);
    if (us?.additionalUserInfo?.isNewUser ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }*/
  }

    // Connexion with facebook
  Future<void> loginWithFaceBook() async {
    final FacebookAuth _facebookAuth = FacebookAuth.instance;
    try {
      final result = await _facebookAuth.login();
      print('loginfacebookOkay!');
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Naviguer vers l'écran principal après une connexion réussie
        print('success!');
      } else {
        // Gestion des erreurs ou annulation de la connexion
        print('fail');
      }
    } catch (e) {
      // Gestion des exceptions
    }
   /* UserCredential? us = await signInWithGoogle(context);
    if (us?.additionalUserInfo?.isNewUser ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }*/
  }
}