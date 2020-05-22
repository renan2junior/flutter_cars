
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fuser = result.user;
      print("Firebase Nome: " + fuser.displayName);
      print("Firebase Email: " + fuser.email);
      print("Firebase Foto: " + fuser.photoUrl);

      // Cria um usuario do app
      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoUrl,
      );
      user.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> login(String login, String senha) async {
    try {
      // Login no Firebase
      AuthResult result = await _auth.signInWithEmailAndPassword(email: login, password: senha);
      final FirebaseUser fuser = result.user;
      print("Firebase Nome: ${fuser.displayName}");
      print("Firebase Email: ${fuser.email}");
      print("Firebase Foto: ${fuser.photoUrl}");

      // Cria um usuario do app
      final user = Usuario(
        nome: fuser.displayName,
        login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoUrl,
      );
      user.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}