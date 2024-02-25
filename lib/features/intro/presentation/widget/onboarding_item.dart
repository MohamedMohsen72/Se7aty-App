import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/features/intro/presentation/data/onboarding_model.dart';


class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(model.image, width: 300),
        Gap(30),
        Text(
          model.title,
          style: getTextTitle(color: AppColor.primarycolor),
        ),
        Gap(15),
        Text(
          model.body,
          textAlign: TextAlign.center,
          style: getTextbady(
            color: AppColor.balckColor,
            fontSize: 17,
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
