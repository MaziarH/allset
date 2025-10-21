import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/onboarding.dart';
import 'package:my_flutter_app/widgets/all_set_logo.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Onboarding();
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF1B1B1B)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AllSetLogo()],
        ),
      ),
    );
  }
}
