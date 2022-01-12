// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/firestore.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  "assets/onboarding1.png",
  "assets/onboarding2.png",
  "assets/onboarding3.png",
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 1200,
                  ),
                ],
              )),
        ))
    .toList();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FCFF),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),

            ///Guest
            Flexible(
              child: LoginButton(
                  icon: FontAwesomeIcons.userNinja,
                  text: 'Continue as guest',
                  loginMethod: AuthService().anonLogin,
                  color: const Color(0xFF84C879)),
            ),

            ///Google
            LoginButton(
                icon: FontAwesomeIcons.google,
                text: 'Sign in with Google',
                loginMethod: AuthService().googleLogin,
                color: Colors.blue),

            ///Apple
            FutureBuilder<Object>(
              future: SignInWithApple.isAvailable(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return SignInWithAppleButton(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    onPressed: () {
                      AuthService().signInWithApple();
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  LoginButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
          onPressed: () {
            loginMethod();
          },
          label: Text(text, textAlign: TextAlign.center),
        ));
  }
}
