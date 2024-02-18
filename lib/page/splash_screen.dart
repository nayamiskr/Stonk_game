import 'package:flutter/material.dart';
import 'package:stonk_app/page/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Good Morning",
            style: TextStyle(
                color: Color.fromARGB(246, 0, 90, 246),
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
    );
  }
}
