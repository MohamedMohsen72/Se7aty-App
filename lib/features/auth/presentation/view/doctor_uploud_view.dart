import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/function/push_pop_function.dart';
import 'package:se7ety/core/widget/custom_dialoges.dart';
import 'package:se7ety/core/widget/custombotton.dart';
import 'package:se7ety/features/auth/presentation/data/doctor_model.dart';
import 'package:se7ety/features/auth/presentation/data/specialization.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_qubit.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_states.dart';

import 'package:se7ety/features/patient/presentation/view/home_view.dart';
import 'package:se7ety/features/patient/presentation/view/navbar.dart';

class DoctorUploud extends StatefulWidget {
  const DoctorUploud({super.key});

  @override
  State<DoctorUploud> createState() => _DoctorUploudState();
}

class _DoctorUploudState extends State<DoctorUploud> {
  User? user;

  File? file;

  String? profilurl;

  var imagePath;

  String? endTime;

  String? startTime;

  Future<void> getuser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  String _specialization = specialization[0];

  // 1) instance from FirebaseStorage with bucket Url..
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://se7ety-d85a8.appspot.com');

  // method to upload and get link of image
  Future<String> uploadImageToFireStore(File image) async {
    //2) choose file location (path)
    var ref = _storage
        .ref()
        .child('doctors/${FirebaseAuth.instance.currentUser!.uid}');
    //3) choose file type (image/jpeg)
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    // 4) upload image to Firebase Storage
    await ref.putFile(image, metadata);
    // 5) get image url
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> pickImage() async {
    getuser();
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
        file = File(PickedFile.path);
      });
    }
    profilurl = await uploadImageToFireStore(file!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is UploudDoctorDataSuccessStates) {
            pushReplacement(context, NavBar());
          } else if (state is UploudDoctorDataErrorStates) {
            ShowErrorDialoge(context, state.error);
          } else {
            ShowLodingDialoge(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text(
                'اكمال عمليه التسجيل',
                style: getTextTitle(color: AppColor.whiteColor),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                backgroundImage: (imagePath != null)
                                    ? FileImage(File(imagePath))
                                        as ImageProvider
                                    : AssetImage('assets/doctor-card.png'),
                                radius: 80,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await pickImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColor.whiteColor,
                                radius: 15,
                                child: Icon(Icons.camera_alt_rounded,
                                    color: AppColor.primarycolor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'التخصص',
                        style: getTextbady(),
                      ),
                    ),
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: AppColor.ScaffoldBG,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButton(
                          hint: Text('ادخل الخصص'),
                          isExpanded: true,
                          iconEnabledColor: AppColor.primarycolor,
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: _specialization,
                          style: getTextbady(fontSize: 19),
                          onChanged: (String? newValue) {
                            setState(() {
                              _specialization = newValue ?? specialization[0];
                            });
                          },
                          items: specialization.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'نبزه تعريفيه',
                        style: getTextbady(),
                      ),
                    ),
                    TextFormField(
                      controller: _bio,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            'سجل معلوماتك الطبيه العامه مثل تعليمك الاكاديمي و خبرتك السابقه...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك ادخل النبزه اللتعرفيه";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'عنوان العياده',
                        style: getTextbady(),
                      ),
                    ),
                    TextFormField(
                      controller: _address,
                      decoration: InputDecoration(
                          hintText: 'شارع9_المقطم_امام ميدان النافورا '),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل العنوان ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ساعات العمل من',
                                  style: getTextbady(),
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: startTime,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.access_time,
                                      color: AppColor.primarycolor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showstartTimePicker();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'الي',
                                  style: getTextbady(),
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: endTime,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.access_time,
                                        color: AppColor.primarycolor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showEndTimePicker();
                                        });
                                      },
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'رقم الهاتف 1',
                        style: getTextbady(),
                      ),
                    ),
                    TextFormField(
                      controller: _phone1,
                      decoration: InputDecoration(hintText: '20xxxxxxxxxxx+'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'رقم الهاتف 2(اختياري)',
                        style: getTextbady(),
                      ),
                    ),
                    TextFormField(
                        controller: _phone2,
                        decoration:
                            InputDecoration(hintText: '20xxxxxxxxxxx+')),
                    Gap(20),
                    CustomElevatedButton(
                      text: 'تسجيل',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().Uplouddoctor(DoctorModel(
                              id: user!.uid,
                              name: user!.displayName ?? '',
                              image: profilurl ?? '',
                              specialization: _specialization,
                              rating: 3,
                              email: user!.email ?? '',
                              phone1: _phone1.text,
                              phone2: _phone2.text,
                              bio: _bio.text,
                              openHour: int.parse(startTime!),
                              closeHour: int.parse(endTime!),
                              address: _address.text));
                        }
                      },
                      foreground: AppColor.whiteColor,
                      background: AppColor.primarycolor,
                      height: 55,
                      wight: double.infinity,
                      style: getTextTitle(
                          color: AppColor.whiteColor, fontSize: 23),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  showstartTimePicker() async {
    final timePicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    if (timePicker != null) {
      setState(() {
        startTime = timePicker.hour.toString();
      });
    }
  }

  showEndTimePicker() async {
    final timePicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    if (timePicker != null) {
      setState(() {
        endTime = timePicker.hour.toString();
      });
    }
  }
}
