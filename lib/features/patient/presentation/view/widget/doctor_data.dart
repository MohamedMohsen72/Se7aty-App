import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/widget/custombotton.dart';

class DoctorData extends StatelessWidget {
  const DoctorData(
      {super.key,
      required this.image,
      required this.name,
      required this.bio,
      required this.Specialization,
      required this.rating,
      required this.openHour,
      required this.closeHour,
      required this.email,
      required this.phone,
      required this.address});
  final String image;
  final String name;
  final String bio;
  final String Specialization;
  final int rating;
  final int openHour;
  final int closeHour;
  final String email;
  final String phone;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'بيانات الدكتور',
          style: getTextTitle(fontSize: 24, color: AppColor.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: getTextTitle(
                              color: AppColor.primarycolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Gap(8),
                        Text(Specialization, style: getTextbady()),
                        Gap(8),
                        Row(
                          children: [
                            Text(
                              rating.toString(),
                              style: getTextbady(),
                            ),
                            Gap(5),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            )
                          ],
                        ),
                        Gap(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: AppColor.ScaffoldBG),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('1'),
                                    Icon(Icons.phone),
                                  ],
                                ),
                              ),
                              Gap(20),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: AppColor.ScaffoldBG),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('2'),
                                    Icon(Icons.phone),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                'نبذه تعريفيه',
                style: getTextbady(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Gap(10),
              Text(
                bio,
                style: getTextsmall(fontSize: 20),
              ),
              Gap(10),
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.ScaffoldBG),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(
                                  100,
                                )),
                            child: Icon(Icons.watch_later_outlined,
                                color: Colors.white),
                          ),
                          Gap(8),
                          Text(openHour.toString(), style: getTextbady()),
                          Text('-', style: getTextbady()),
                          Text(closeHour.toString(), style: getTextbady()),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(
                                  100,
                                )),
                            child: Icon(Icons.location_on_rounded,
                                color: Colors.white),
                          ),
                          Gap(8),
                          Text(address, style: getTextbady()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Gap(20),
              Text(
                'معلومات الاتصال',
                style: getTextbady(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Gap(10),
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.ScaffoldBG),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(
                                  100,
                                )),
                            child: Icon(Icons.email, color: Colors.white),
                          ),
                          Gap(8),
                          Text(email, style: getTextbady()),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(
                                  100,
                                )),
                            child: Icon(Icons.phone, color: Colors.white),
                          ),
                          Gap(8),
                          Text(phone, style: getTextbady()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(50),
              CustomElevatedButton(
                text: 'احجز موعدك الان',
                onPressed: () {},
                radius: 10,
                foreground: AppColor.whiteColor,
                background: AppColor.primarycolor,
                height: 55,
                wight: double.infinity,
                style: getTextTitle(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
