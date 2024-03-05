

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/Utils/color.dart';

ShowErrorDialoge( context, Texterror) {
  ScaffoldMessenger.of( context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsetsDirectional.all(15),
      content: Text(Texterror)));
}

ShowLodingDialoge(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: AppColor.balckColor.withOpacity(0.7),
    context: context,
    builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Lottie.asset('assets/loadingg.json',height: 150,width: 150)],
      );
    },
  );
}
