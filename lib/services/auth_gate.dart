import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/home.dart';
import 'package:food_delivery_app/screens/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  ///
  final stream = Supabase.instance.client.auth.onAuthStateChange;

  ///
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator.adaptive()],
              ),
            ),
          );
        }
        
        ///
        final Session? session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return const Home();
        } else {
          return const SignUp();
        }
      },
    );
  }
}
