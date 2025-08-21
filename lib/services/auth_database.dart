import 'package:food_delivery_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDatabase {
  /// Singleton
  AuthDatabase._private();

  static final _instance = AuthDatabase._private();

  static AuthDatabase get instance => _instance;

  /// Supabase database
  final SupabaseClient supabase = Supabase.instance.client;

  /// Fetch data from database
  Future<void> fetchData() async {
    final spb = Supabase.instance.client;
    await spb.from('users').select();
  }

  /// Insert data
  Future<void> insertData(UserModel user) async {
    final spb = Supabase.instance.client;
    await spb.from("users").insert(user.toMap());
  }
}
