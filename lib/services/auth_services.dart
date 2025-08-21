import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  /// Singleton class
  AuthServices._private();
  static final AuthServices _instance = AuthServices._private();
  static AuthServices get instance => _instance;

  /// Supabase instance here
  final SupabaseClient supabase = Supabase.instance.client;

  /// Get current user
  final User? _user = Supabase.instance.client.auth.currentUser;
  User? get user => _user;
  String? getUserEmail () {
    Session? session = supabase.auth.currentSession;
    User? user = session?.user;
    return user?.email ?? "Email non disponible";
  }

  /// Sign up with email
  Future<void> signUpWithEmail(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  /// Sign in with email
  Future<void> signInWithEmail(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  /// Sign out
  Future<void> signOut(BuildContext context) async {
    await supabase.auth.signOut().whenComplete(() {
      if(context.mounted) {
        Navigator.of(context).pushReplacementNamed("/authGate");
      }
    });
  }
}
