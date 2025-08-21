import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ///
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode phoneNumberFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: white,

        /*App bar content here*/

        appBar: AppBar(backgroundColor: white),

        /*Body content here*/

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Création de compte !", style: h1),
              const SizedBox(height: 8),
              Text(
                "Créez un compte et passez vite votre commande",
                style: bodyText,
              ),
              const SizedBox(height: 32),
              Consumer<AuthProvider>(builder: (_, signProv, _) {
                return Form(
                  key: signProv.signUpKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: const Color(0xffefefef),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Email address
                            TextFieldWidget(
                              label: "Adresse mail",
                              hintText: "exemple@gmail.com",
                              focusNode: emailFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(passwordFocusNode);
                              },
                              validator: (val) {
                                ///
                                if (val == null || val.isEmpty) {
                                  return "Veuillez entrer votre adresse mail";
                                } else {
                                  return null;
                                }
                              },
                              controller: signProv.signEmailController,
                              showIcon: false,
                            ),
                            const SizedBox(height: 4),
                            /// Password
                            TextFieldWidget(
                              label: "Mot de passe",
                              hintText: "••••••••",
                              focusNode: passwordFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(phoneNumberFocusNode);
                              },
                              validator: (val) {
                                ///
                                if (val == null || val.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
                                } else {
                                  return null;
                                }
                              },
                              controller: signProv.signPasswordController,
                              showIcon: true,
                            ),
                            const SizedBox(height: 4),
                            /// Phone number
                            TextFieldWidget(
                              label: "Téléphone",
                              hintText: "+221771234567",
                              focusNode: phoneNumberFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (val) {
                                ///
                                if (val == null || val.isEmpty) {
                                  return "Votre numéro de téléphone est requis";
                                } else {
                                  return null;
                                }
                              },
                              controller: signProv.signPhoneNumberController,
                              showIcon: false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      MaterialButton(
                        onPressed: () {
                          signProv.signUp(context);
                        },
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        color: purple,
                        minWidth: double.maxFinite,
                        child: Text(
                          "Créer mon compte",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Déjà un compte ?", style: bodyText),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthProvider>().clearSignupControllers();
                              Navigator.of(context).pushNamed("/logIn");
                            },
                            child: Text("Se connecter", style: linkText),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
