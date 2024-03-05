
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';

class carddoctor extends StatelessWidget {
  const carddoctor({
    super.key, required this.image, required this.doctorname, required this.specialization, required this.rating,
  });
 final String image;
 final String doctorname;
  final String specialization;
  final int rating;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.ScaffoldBG,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
             Image.network( image ),
              const Gap(10),
              Column(
                children: [
                  Text(
                    doctorname,
                    style: getTextTitle(
                      color: AppColor.primarycolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    specialization,
                    style: getTextsmall(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                rating.toString(),
                style: TextStyle(fontSize: 18),
              ),
              const Gap(5),
              Icon(
                Icons.star,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
