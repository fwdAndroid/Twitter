import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/models/usermodel.dart';

class FirebaseAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  //Register
  Future<void> signUpTwitter(String email, String password) async {
    try {
      // ignore: unnecessary_cast
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Add User To DataBase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
        'name': email,
        'email': email,
      });
      //End Adding User To Firebase

      _userFromFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //Sign In
  Future<void> signInTwitter(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)) as User;
      _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //SignOut
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  //Check User SignIn or Not
  Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
    //  .map((User? user) => _userFromFirebaseUser(user));
  }
}
