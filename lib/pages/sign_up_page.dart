import 'package:flutter/material.dart';
import 'package:stalkin/pages/sign_in_page.dart';

import '../theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 120, bottom: 100),
                  child: Text(
                    'Register',
                    style: logoText.copyWith(fontSize: 32, color: whiteColor),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: nameController,
                    style: regularPoppins.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: whiteColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Name",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: emailController,
                    style: regularPoppins.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: whiteColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Email",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: regularPoppins.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: whiteColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: regularPoppins.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: whiteColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Confirm Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: regularPoppins.copyWith(
                          fontSize: 14, color: whiteColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle navigation to the sign up page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: boldPoppins.copyWith(
                            fontSize: 14, color: secondaryColor),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 303,
                  height: 48,
                  margin: const EdgeInsets.only(top: 88),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: semiPoppins.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
