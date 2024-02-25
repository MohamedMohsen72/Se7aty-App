import 'package:flutter/material.dart';
import 'package:se7ety/features/intro/presentation/view/onboarding_view.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 4),(){
      return
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardingView(),));

  });


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children:
          [Center(child: Image.asset('assets/Se7te.png',width: 300)),


          ]),
    );
  }
}
