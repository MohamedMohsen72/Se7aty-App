import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';

import 'package:se7ety/features/patient/presentation/data/card_model.dart';
import 'package:se7ety/features/patient/presentation/view/widget/Explore_specialization.dart';
import 'package:se7ety/features/patient/presentation/view/widget/custom_carditem.dart';
import 'package:se7ety/features/patient/presentation/view/widget/doctor_data.dart';
import 'package:se7ety/features/patient/presentation/view/widget/topRate.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User? user;

  Future<void> getuser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('صــــــحّـتــي',
            style: getTextTitle(fontWeight: FontWeight.w700, fontSize: 24)),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'مرحبا، ',
                          style: getTextbady(fontSize: 18),
                        ),
                        TextSpan(
                          text: user?.displayName,
                          style: getTextTitle(
                              color: AppColor.primarycolor, fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: getTextTitle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              Gap(26),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.greyColor.withOpacity(0.8),
                          offset: Offset(5, 5),
                          blurRadius: 12)
                    ]),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن دكتور',
                    hintStyle: getTextbady(),
                    suffixIcon: Container(
                      width: 60,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColor.primarycolor),
                      child: Icon(Icons.search,
                          color: AppColor.whiteColor, size: 30),
                    ),
                  ),
                ),
              ),
              Gap(26),
              Text(
                'التخصصات',
                style: getTextTitle(
                    color: AppColor.primarycolor, fontWeight: FontWeight.bold),
              ),
              Gap(18),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: card.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Explore_specialization(
                              Specialization: card[index].doctor),
                        ));
                      },
                      child: carditem(
                        BGcard: card[index].background,
                        Title: card[index].doctor,
                        lightcolor: card[index].lightcolor,
                      ),
                    );
                  },
                ),
              ),
              Gap(18),
              Text(
                'الاعلي تقييما',
                style: getTextTitle(
                    color: AppColor.primarycolor, fontWeight: FontWeight.bold),
              ),
              Gap(18),
              TopRated()
            ],
          ),
        ),
      ),
    );
  }
}
