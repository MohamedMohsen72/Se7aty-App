import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/features/intro/presentation/view/onboarding_view.dart';
import 'package:se7ety/features/patient/presentation/view/home_view.dart';
import 'package:se7ety/features/patient/presentation/view/navbar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  User? user;

  Future<void> getuser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    Future.delayed(Duration(seconds: 4), () {
      return Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>(user!=null) ?NavBar() :OnBoardingView(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(child: Image.asset('assets/Se7te.png', width: 300)),
      ]),
    );
  }
}
