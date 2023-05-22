import 'package:flutter/material.dart';
import 'package:stalkin/pages/sign_in_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                    );
                  });
                },
                child: const Text('LogOut'))
          ],
        ),
      ),
    );
  }
}
