import 'package:flutter/material.dart';
import 'signup.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart'; // make sure AppConfig.loginUrl is defined here
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  Future<void> signInUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final url = Uri.parse(AppConfig.loginUrl);
    final body = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final fullName = data['user']['fullName'] ?? "User";
        final role = data['user']['role'] ?? "";
        final userId = data['user']['id'];
        final token = data['token'] ?? "";

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("fullName", fullName);
        await prefs.setString("token", token);
        await prefs.setString("role", role);
        await prefs.setInt("userId", userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful! Welcome $fullName")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1B1B1B),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  "Hello\nSign In!",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 36.0,
                    fontFamily: 'Telegraf',
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Container(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 40.0,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                          fontSize: 23.0,
                          fontFamily: 'Telegraf',
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter your email" : null,
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                          fontSize: 23.0,
                          fontFamily: 'Telegraf',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter your password" : null,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color(0xFF1B1B1B),
                              fontSize: 18.0,
                              fontFamily: 'Telegraf',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      GestureDetector(
                        onTap: _loading ? null : signInUser,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B1B1B),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: _loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 24.0,
                                      fontFamily: 'Telegraf',
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          "OR SIGN IN WITH",
                          style: TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontFamily: 'Telegraf',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Image.asset(
                              'assets/icons/google.png',
                              height: 30.0,
                              width: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Color(0xFF1B1B1B),
                                  fontSize: 16.0,
                                  fontFamily: 'Telegraf',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Color(0xFF38B6FF),
                                    fontSize: 18.0,
                                    fontFamily: 'Telegraf',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
GestureDetector(
  onTap: () async {
    final Uri _url = Uri.parse("https://foodirectory.ca");
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  },
  child: const Text(
    "Become a Vendor",
    style: TextStyle(
      color: Color(0xFF38B6FF),
      fontSize: 18.0,
      fontFamily: 'Telegraf',
      decoration: TextDecoration.underline,
    ),
  ),
),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
