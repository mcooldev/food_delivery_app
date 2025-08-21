import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/providers/onboarding_provider.dart';
import 'package:food_delivery_app/widgets/onboarding_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  ///

  ///
  @override
  Widget build(BuildContext context) {
    ///
    final onWatch = context.watch<OnBoardingProvider>();
    final onRead = context.read<OnBoardingProvider>();
    ///
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.only(right: 16),
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: onWatch.index == i ? purple : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signUp');
            },
            elevation: 0,
            shape: ContinuousRectangleBorder(
              side: BorderSide(width: 1, color: strokeColor),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Text('Passer', style: linkText),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          PageView(
            controller: onWatch.pageController,
            onPageChanged: onWatch.onPageChange,
            children: const [
              OnboardingView(
                image: "assets/onBoardingImage1.png",
                title: "La faim ? Faites-vous livrer en un clic !",
                description:
                    "Envie de vos plats préférés sans bouger de chez vous ? MyFood vous connecte aux meilleurs menus, avec une livraison rapide et facile.",
              ),
              OnboardingView(
                image: "assets/onBoardingImage2.png",
                title: "Découvrez un monde de saveurs !",
                description:
                    "Explorez une large sélection de cuisines : locale, internationale, vos restaurants favoris et de nouvelles découvertes."
              ),
              OnboardingView(
                image: "assets/onBoardingImage3.jpeg",
                title: "Prêt(e) à commander ?",
                description:
                    "Créez votre compte pour enregistrer vos adresses, vos méthodes de paiement préférées et recevoir des offres spéciales, des réductions.",
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: MaterialButton(
              onPressed: () {
                onRead.onTapButton(context);
              },
              elevation: 0,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: purple,
              child: onWatch.index == 2 ? Text(
                "Commencer",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ) : Text(
                "Suivant",
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
