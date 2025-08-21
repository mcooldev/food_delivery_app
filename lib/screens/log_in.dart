import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../providers/auth_provider.dart';
import '../widgets/text_field_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(backgroundColor: white),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Se connecter !", style: h1),
              const SizedBox(height: 8),
              Text(
                "Connectez-vous et passez vite votre commande",
                style: bodyText,
              ),
              const SizedBox(height: 32),
              Consumer<AuthProvider>(builder: (_, logProv, _) {
                return Form(
                  key: logProv.logInKey,
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
                              controller: logProv.logEmailController,
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
                                ).unfocus();
                              },
                              validator: (val) {
                                ///
                                if (val == null || val.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
                                } else {
                                  return null;
                                }
                              },
                              controller: logProv.logPasswordController,
                              showIcon: true,
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      MaterialButton(
                        onPressed: () {
                          logProv.logIn(context);
                        },
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        color: purple,
                        minWidth: double.maxFinite,
                        child: Text(
                          "Se connecter maintenant",
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
                          Text("Pas encore de compte ?", style: bodyText),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthProvider>().clearLoginControllers();
                              Navigator.of(context).pushNamed("/signUp");
                            },
                            child: Text("S'enregistrer", style: linkText),
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
