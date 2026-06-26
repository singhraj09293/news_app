import 'package:flutter/material.dart';
import 'package:news_app/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delay();
  }

  void delay() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icon/logo.jpg', height: 200, width: 200),
                SizedBox(height: 20),
                Text(
                  'NewzLy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE63946),
                    fontSize: 30,
                  ),
                ),
                Text(
                  'News that moves with you',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFFE63946)),
            ),
          ),
        ],
      ),
    );
  }
}
