import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/function/push_pop_function.dart';
import 'package:se7ety/features/patient/presentation/view/widget/custom_carddoctor.dart';
import 'package:se7ety/features/patient/presentation/view/widget/doctor_data.dart';

class Explore_specialization extends StatefulWidget {
  final String Specialization;

  const Explore_specialization({super.key, required this.Specialization});

  @override
  State<Explore_specialization> createState() => _Explore_specializationState();
}

class _Explore_specializationState extends State<Explore_specialization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.whiteColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:
              Text(widget.Specialization, style: getTextTitle(color: AppColor.whiteColor,fontSize: 24)),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('doctor')
                .where('Specialization', isEqualTo: widget.Specialization)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot>
                    snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }else{
                return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doctor = snapshot.data!.docs[index];
                    if (doctor['name'] == null ||
                        doctor['Specialization'] == null ||
                        doctor['image'] == null ||
                        doctor['rating'] == null) {
                      return SizedBox();
                    }
                    return GestureDetector(
                      onTap: () {
                        push(context, DoctorData(image: doctor['image'],
                          name: doctor['name'],
                          bio: doctor['bio'],
                          Specialization: doctor['Specialization'],
                          rating: doctor['rating'],
                          closeHour: doctor['closeHour'],
                          openHour: doctor['openHour'],
                          email: doctor['email'],
                          phone: doctor['phone'], address: doctor['address'],));
                      },
                      child: carddoctor(
                        image: doctor['image'],
                        specialization: doctor['Specialization'],
                        doctorname: doctor['name'],
                        rating: doctor['rating'],
                      ),
                    );
                  },
                );
              }
            }));
  }
}
