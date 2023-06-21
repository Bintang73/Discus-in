import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_captcha.dart';
import 'dart:math';

import '../theme.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final SliderController _sliderController = SliderController();

  bool _showSliderCaptcha = true;
  bool _passwordVisible = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSliderCaptchaResult(bool result) {
    setState(() {
      _showSliderCaptcha = false; // Close the SliderCaptcha
    });

    if (result) {
      _signUp(); // Auto-login if the SliderCaptcha result is true
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Puzzle Chapctha Invalid!',
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future _signUp() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (isPasswordConfirmed()) {
        // create user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // collect user document
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.email)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'bio': 'Empthy bio..',
          'urlProfile':
              'https://api.multiavatar.com/${_nameController.text}.png'
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Password tidak sama',
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
        ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.code,
          style: semiPoppins,
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future addUserDetails(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'bio': 'My Bio',
      'urlProfile': 'https://api.multiavatar.com/Binx%20Bond.png',
    });
  }

  bool isPasswordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void _showSliderCaptchaDialog() {
    Random rnd;
    int min = 1;
    int max = 20;
    rnd = Random();
    int numberRnd = min + rnd.nextInt(max - min);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(12), // Specify the border radius here
            child: Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SliderCaptcha(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
                title: 'Geser untuk verifikasi',
                titleStyle: semiPoppins,
                controller: _sliderController,
                image: Image.asset(
                  "assets/captcha/$numberRnd.jpg",
                  fit: BoxFit.fitWidth,
                ),
                colorBar: secondaryColor,
                colorCaptChar: secondaryColor,
                onConfirm: (values) async {
                  debugPrint(
                    values.toString(),
                  );
                  await Future.delayed(
                    const Duration(seconds: 1),
                  );
                  _sliderController.create.call();
                  if (values == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    _handleSliderCaptchaResult(true);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Puzzle Chapctha Invalid!',
                          style: semiPoppins,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

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
                    controller: _nameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: mainColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
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
                    controller: _confirmPasswordController,
                    obscureText: !_passwordVisible,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: mainColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
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
                      onTap: widget.showLoginPage,
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
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Masukkan Email & Password!',
                              style: semiPoppins,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        if (!_showSliderCaptcha) {
                          _signUp();
                        } else {
                          _showSliderCaptchaDialog();
                        }
                      }
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
