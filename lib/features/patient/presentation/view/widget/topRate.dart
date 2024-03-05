import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/function/push_pop_function.dart';

import 'package:se7ety/features/patient/presentation/view/widget/custom_carddoctor.dart';
import 'package:se7ety/features/patient/presentation/view/widget/doctor_data.dart';

class TopRated extends StatefulWidget {
  const TopRated({Key? key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctor')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox(
              height: 250,
              child: ListView.builder(
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
              ),
            );
          }
        },
      ),
    );
  }
}
