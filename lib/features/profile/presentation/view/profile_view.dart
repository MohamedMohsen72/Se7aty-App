import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';

class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  User? user;

  Future<void> getuser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColor.whiteColor),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: Text(
          'الحساب الشخصي',
          style: getTextTitle(color: AppColor.whiteColor, fontSize: 24),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('patient').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(alignment: Alignment.bottomRight, children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColor.whiteColor,
                        backgroundImage:AssetImage (
                          'assets/doc.png'
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(Icons.camera_alt_rounded,
                            color: AppColor.primarycolor),
                      )
                    ]),
                    Column(
                      children: [
                        Text(
                          'محمد محسن',
                          style: getTextTitle(
                              color: AppColor.primarycolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Gap(20),
                        Text(
                          'القاهره',
                          style: getTextbady(),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(10),
                Text(
                  'نبذه تعريفيه',
                  style: getTextbady(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Gap(10),
                Text(
                  'لم تضاف',
                  style: getTextbady(fontSize: 16),
                ),
                Gap(10),
                Divider(),
                Gap(20),
                Text(
                  'معلومات التواصل',
                  style: getTextbady(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Gap(15),
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
                            Text('mohame@gmail.com', style: getTextbady()),
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
                            Text('01065408426', style: getTextbady()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(5),
                Divider(),
                Gap(10),
                Text(
                  'جوزاتي',
                  style: getTextbady(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لاتوجد حجزات سابقه',
                      style: getTextbady(),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
