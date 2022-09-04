import 'package:chat_app/view/Auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Fun Olympics \nGames",
                  style: GoogleFonts.cabin(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: SizedBox(
        //   height: 50,
        //   child: Text(
        //     "Powered by: Techlearners.info",
        //     textAlign: TextAlign.center,
        //     style: GoogleFonts.aBeeZee(
        //         fontWeight: FontWeight.bold, color: Colors.cyan),
        //   ),
        // ),
      ),
    );
  }
}
