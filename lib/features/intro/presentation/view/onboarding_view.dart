import 'package:flutter/material.dart';

import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/features/intro/presentation/data/onboarding_model.dart';
import 'package:se7ety/core/widget/custombotton.dart';
import 'package:se7ety/features/intro/presentation/widget/onboarding_item.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<OnBoardingModel> pages = [
    OnBoardingModel(
        image: "assets/on1.png",
        title: 'ابحث عن دكتور متخصص',
        body:
            'اكتشف مجموعه واسعه من الاطباء الخبراء و المتخصصين في مختلف المجالات'),
    OnBoardingModel(
        image: "assets/on2.png",
        title: 'سهوله الحجز',
        body: 'احجز المواعيد بضغطه زر في اي وقت واي مكان'),
    OnBoardingModel(
        image: "assets/on3.png",
        title: 'امن وسري',
        body: 'كن مطمئنا الان خصوصيتك وامانك هما اهم اولوياتنا')
  ];
  var pagecontroller = PageController();
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'تخطي',
              style: getTextsmall(color: AppColor.primarycolor),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    index=value;
                  });
                },
                itemCount: pages.length,
                controller: pagecontroller,
                itemBuilder: (context, index) {
                  return OnboardingItem(model: pages[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  effect: WormEffect(
                      activeDotColor: AppColor.primarycolor, dotHeight: 10),
                  controller: pagecontroller,
                  // PageController
                  count: 3,
                ),
                (index==2)?
                CustomElevatedButton(
                  height: 45,
                  background: AppColor.primarycolor,
                  foreground: AppColor.whiteColor,
                  onPressed: () {},
                  text: 'هيا بنا',
                ):
                    SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}


