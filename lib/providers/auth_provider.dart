import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/services/auth_database.dart';
import 'package:food_delivery_app/services/auth_services.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class AuthProvider with ChangeNotifier {
  /// Sign up key and controllers
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  GlobalKey<FormState> get signUpKey => _signUpKey;
  final TextEditingController signEmailController = TextEditingController();
  final TextEditingController signPasswordController = TextEditingController();
  final TextEditingController signPhoneNumberController =
      TextEditingController();

  /// Log in key and controllers
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  GlobalKey<FormState> get logInKey => _logInKey;
  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();

  /// AuthServices instance
  final auth = AuthServices.instance;

  /// Sign up function
  Future<void> signUp(BuildContext context) async {
    if (_signUpKey.currentState!.validate()) {
      try {
        /// Sign up
        await auth.signUpWithEmail(
          signEmailController.text,
          signPasswordController.text,
        );

        /// Insert phone number to the database
        final db = AuthDatabase.instance;
        final user = UserModel(phone: signPhoneNumberController.text);
        if (signPhoneNumberController.text.isNotEmpty) {
          await db.insertData(user);
        }

        /// show modal bottom sheet
        if (!context.mounted) return;
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (_) {
            return SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: double.maxFinite,
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 64,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Votre compte à été créé avec succès",
                      style: bodyText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        /// sign up controllers
        signEmailController.clear();
        signPasswordController.clear();
        signPhoneNumberController.clear();

        /// waiting for 3 seconds before redirecting to the home screen
        Timer(const Duration(seconds: 3), () {
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/authGate");
          }
        });
      } catch (e) {
        log("Error: $e");
      }
      notifyListeners();
    }
  }

  /// Log in function
  Future<void> logIn(BuildContext context) async {
    if (_logInKey.currentState!.validate()) {
      try {
        /// Log in
        await auth.signInWithEmail(
          logEmailController.text,
          logPasswordController.text,
        );

        /// show modal bottom sheet
        if (!context.mounted) return;
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (_) {
            return SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: double.maxFinite,
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 64,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Connexion réussie",
                      style: bodyText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        /// log in controllers
        logEmailController.clear();
        logPasswordController.clear();

        /// waiting for 3 seconds before redirecting to the home screen
        Timer(const Duration(seconds: 3), () {
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed("/authGate");
          }
        });
      } catch (e) {
        log("Error: $e");
      }
      notifyListeners();
    }
  }

  /// Clear sign up controllers
  void clearSignupControllers() {
    signEmailController.clear();
    signPasswordController.clear();
    signPhoneNumberController.clear();
    notifyListeners();
  }

  /// Clear log in controllers
  void clearLoginControllers() {
    logEmailController.clear();
    logPasswordController.clear();
    notifyListeners();
  }

  /// Dispose controller properly
  @override
  void dispose() {
    /// Dispose sign up controllers
    signEmailController.dispose();
    signPasswordController.dispose();
    signPhoneNumberController.dispose();

    /// Dispose log in controllers
    logEmailController.dispose();
    logPasswordController.dispose();
    super.dispose();
  }
}
