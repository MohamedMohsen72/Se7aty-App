import 'dart:ui';

import 'package:se7ety/features/auth/presentation/data/specialization.dart';

const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);
const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);
const Color purple = Color(0xff8873f4);
const Color purpleLight = Color(0xff9489f4);
const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3);

class CardModel{

 final String doctor;
 final Color background;
 final Color lightcolor;
  CardModel( {required this.lightcolor,required this.doctor, required this.background});




}

List<CardModel>card=[
  CardModel(doctor:specialization[0] ,background:skyBlue, lightcolor: lightBlue  ,),
  CardModel(doctor: specialization[1], background: orange, lightcolor: lightOrange),
  CardModel(doctor: specialization[2], background: purple, lightcolor: purpleLight),
  CardModel(doctor: specialization[3], background: green, lightcolor: lightGreen),
  CardModel(doctor: specialization[4], background: skyBlue, lightcolor: lightBlue),
  CardModel(doctor: specialization[5], background: orange, lightcolor:  lightOrange),
  CardModel(doctor: specialization[6], background: purple, lightcolor:  purpleLight),
  CardModel(doctor: specialization[7], background: green, lightcolor: lightGreen),
  CardModel(doctor: specialization[8], background: skyBlue, lightcolor: lightBlue),
  CardModel(doctor: specialization[9], background: orange, lightcolor: lightOrange),

];