import 'package:anxiety_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserModel> loginUser(
    String email,
    String password,
  ) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel(user.user!.email, password);
  }

  Future<UserModel> registerUser(
    String email,
    String password,
  ) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(user.user!.email, password);
  }
}
