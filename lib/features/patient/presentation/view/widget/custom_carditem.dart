import 'package:flutter/material.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/features/patient/presentation/data/card_model.dart';
import 'package:se7ety/features/patient/presentation/view/widget/Explore_specialization.dart';

class carditem extends StatelessWidget {


  const carditem({
    super.key, required this.BGcard, required this.Title, required this.lightcolor,
  });
  final Color BGcard;
  final String Title;
  final Color lightcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 250,
        width: 180,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  color: lightcolor.withOpacity(0.7),
                  offset: Offset(3, 3))
            ],
            borderRadius: BorderRadius.circular(25),
            color: BGcard),
        child: ClipRect(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 100,
                left: 50,
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor:
                  AppColor.whiteColor.withOpacity(0.2),
                ),
              ),
              Image.asset('assets/doctor-card.png'),
              Positioned(
                  top: 180,
                  child: Text(
                    Title,
                    style:
                    getTextbady(color: AppColor.whiteColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
