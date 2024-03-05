import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/function/push_pop_function.dart';
import 'package:se7ety/core/widget/custombotton.dart';
import 'package:se7ety/features/auth/presentation/view/login_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/welcome-bg.png'),
                  fit: BoxFit.cover,
                  opacity: 0.7),
            ),
          ),
          Positioned(
            top: 100,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اهلا بيك',
                  style: getTextTitle(
                      fontSize: 37,
                      color: AppColor.primarycolor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'سجل واحجز عند دكتورك وانت في البيت',
                  style: getTextbady(),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            height: 250,
            left: 20,
            right: 20,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.primarycolor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'سجل دلوقتي ك',
                        style: getTextbady(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gap(30),
                    CustomElevatedButton(
                      text: 'دكتور',
                      onPressed: () {
                        push(context, LoginView(index:0));
                      },
                      foreground: AppColor.balckColor,
                      background: AppColor.ScaffoldBG,
                      height: 55,
                      wight: 300,
                    ),
                    Gap(20),
                    CustomElevatedButton(
                      text: 'مريض',
                      onPressed: () {
                        push(context, LoginView(index: 1,));
                      },
                      foreground: AppColor.balckColor,
                      background: AppColor.ScaffoldBG,
                      height: 55,
                      wight: 300,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
