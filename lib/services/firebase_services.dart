import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirbaseServices {

  static Future <DocumentSnapshot>adminSignIn(id) async{
     var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;

  }
   

  
  static Future<String?> createAccount(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email Already in use";
      } else if (e.code == "weak-password") {
        return "Password is Too Weak";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    
  }

  static Future<String?> signInAccount(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email Already in use";
      } 
      return e.message;
    } catch (e) {
      return e.toString();
    }

  }
  
}
