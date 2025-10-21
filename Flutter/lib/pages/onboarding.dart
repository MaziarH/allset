import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/signin.dart';
import 'package:my_flutter_app/pages/signup.dart';
import 'package:my_flutter_app/widgets/all_set_logo.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF1B1B1B),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's Get You",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Telegraf',
                fontSize: 30.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            AllSetLogo(),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFFFFFF), width: 2.0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'Telegraf',
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "SIGN UP ",
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontFamily: 'Telegraf',
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            
          ],
        ),
      ),
    );
  }
}
