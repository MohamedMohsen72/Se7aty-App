import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_qubit.dart';

import 'package:se7ety/features/intro/presentation/view/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyC9PA3aPhvHpY9t1STHbL5Zgt0yW_WEn3o',
          appId: 'com.example.se7ety',
          projectId: 'se7ety-d85a8',
          messagingSenderId: '753658607670'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.only(left: 30, bottom: 20, right: 20, top: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColor.ScaffoldBG,
                suffixIconColor: AppColor.primarycolor,
                prefixIconColor: AppColor.primarycolor,
                hintStyle:
                    GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(backgroundColor: AppColor.primarycolor)),
          debugShowCheckedModeBanner: false,
          home: SplashView(),
          builder: (context, child) {
            return Directionality(
                textDirection: TextDirection.rtl, child: child!);
          },
        ));
  }
}
