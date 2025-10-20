import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'signin.dart';
import 'main.dart';
import 'config.dart'; // <-- same as before (AppConfig)

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // ---------------- Register User ----------------
  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = Uri.parse(AppConfig.registerUrl);
    //final fullName = "${_firstNameController.text} ${_lastNameController.text}";

    final body = {
      "fullName": _fullNameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "password": _passwordController.text.trim(),
      "address": "", // optional
      "role": "Customer", // default
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful! Logging in...")),
        );
        await _loginUser(_emailController.text, _passwordController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ---------------- Login User ----------------
  Future<void> _loginUser(String email, String password) async {
    final loginUrl = Uri.parse(AppConfig.loginUrl);

    try {
      final response = await http.post(
        loginUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        final token = data['token'] ?? "";
        final fullName = data['user']?['fullName'] ?? "";
        final role = data['user']?['role'] ?? "Customer";
        final userId = data['user']?['id'] ?? 0;

        await prefs.setString("token", token);
        await prefs.setString("fullName", fullName);
        await prefs.setString("role", role);
        await prefs.setInt("userId", userId);

        // If vendor, create vendor record
        if (role == "Vendor" && userId != 0) {
          try {
            final postUrl = Uri.parse(AppConfig.createVendor(userId));
            final postRes = await http.post(
              postUrl,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
              body: jsonEncode({"userId": userId}),
            );

            if (postRes.statusCode != 201 && postRes.statusCode != 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Vendor creation failed: ${postRes.body}")),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vendor creation error: $e")),
            );
          }
        }

        // Navigate
        if (role == "Vendor") {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => const VendorScreen()),
          // );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login error: $e")),
      );
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Create Your\nAccount!",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 40.0,
                      fontFamily: 'Telegraf',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Full Name"),
                      TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter your fullname",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (v) => v!.isEmpty ? "Enter full name" : null,
                      ),
                      const SizedBox(height: 10.0),

                      // _buildLabel("Last Name"),
                      // TextFormField(
                      //   controller: _lastNameController,
                      //   decoration: const InputDecoration(
                      //     hintText: "Enter Last Name",
                      //     prefixIcon: Icon(Icons.person_outline),
                      //   ),
                      //   validator: (v) => v!.isEmpty ? "Enter last name" : null,
                      // ),
                      // const SizedBox(height: 10.0),

                      _buildLabel("Phone Number"),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: "Enter Phone Number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (v) => v!.isEmpty ? "Enter phone number" : null,
                      ),
                      const SizedBox(height: 10.0),

                      _buildLabel("Email"),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) => v!.isEmpty ? "Enter email" : null,
                      ),
                      const SizedBox(height: 10.0),

                      _buildLabel("Password"),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: (v) => v!.isEmpty ? "Enter password" : null,
                      ),
                      const SizedBox(height: 20.0),

                      // --- Sign Up Button ---
                      GestureDetector(
                        onTap: _isLoading ? null : registerUser,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: _isLoading
                                ? Colors.grey
                                : const Color(0xFF1B1B1B),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    "SIGN UP",
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
                          "OR SIGN UP WITH",
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
                      const SizedBox(height: 20.0),

                      // --- Sign In Link ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Color(0xFF1B1B1B),
                                  fontSize: 17.0,
                                  fontFamily: 'Telegraf',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Color(0xFF38B6FF),
                                    fontSize: 18.0,
                                    fontFamily: 'Telegraf',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1B1B1B),
        fontSize: 20.0,
        fontFamily: 'Telegraf',
      ),
    );
  }
}
