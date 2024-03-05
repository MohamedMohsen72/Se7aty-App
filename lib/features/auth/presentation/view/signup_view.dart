import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/function/emailvalidate.dart';
import 'package:se7ety/core/function/push_pop_function.dart';
import 'package:se7ety/core/widget/custom_dialoges.dart';
import 'package:se7ety/core/widget/custombotton.dart';
import 'package:se7ety/features/auth/presentation/view/doctor_uploud_view.dart';
import 'package:se7ety/features/auth/presentation/view/login_view.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_qubit.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_states.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<RegisterView> createState() => _LoginViewState();
}

class _LoginViewState extends State<RegisterView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController displayName = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isnotvesable = true;
  String handleUserType() {
    return widget.index == 0 ? "دكتور" : "مريض";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
            pushAndRemoveUntil(context, const DoctorUploud());
          } else if (state is RegisterErrorStates) {
            Navigator.pop(context);
            ShowErrorDialoge(context, state.error);
          } else {
            ShowLodingDialoge(context);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Se7te.png', height: 300),
                        Text(
                          'سجل حساب جديد كـ "${handleUserType()}"',
                          style: getTextTitle(
                              color: AppColor.primarycolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Gap(20),
                        TextFormField(
                          controller: displayName,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                size: 27,
                              ),
                              hintText: 'الاسم'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل الاسم';
                            }
                          },
                        ),
                        Gap(20),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                size: 27,
                              ),
                              hintText: 'mohamed@gmil.com'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل الايميل';
                            } else if (!emailvalidate(value)) {
                              return 'من فضل ادخل الاميل صحيحا';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isnotvesable,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 27,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isnotvesable = !isnotvesable;
                                    });
                                  },
                                  icon: (isnotvesable)
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.visibility_off_rounded)),
                              hintText: '***************'),
                          validator: (value) {
                            if (value!.isEmpty) return 'من فضلك ادخل كلمه السر';
                            return null;
                          },
                        ),
                        Gap(25),
                        CustomElevatedButton(
                            text: 'تسجل حساب',
                            style: getTextTitle(
                                fontSize: 24, color: AppColor.whiteColor),
                            radius: 25,
                            onPressed: () {
                              if (widget.index == 1) {
                                if (formkey.currentState!.validate()) {
                                  context
                                      .read<AuthCubit>()
                                      .createUserWithEmailAndPassword(
                                        displayName.text,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                } else {
                                  if (formkey.currentState!.validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .createdoctorWithEmailAndPassword(
                                          displayName.text,
                                          emailController.text,
                                          passwordController.text,
                                        );
                                  }
                                }
                              }
                            },
                            foreground: Colors.white,
                            background: AppColor.primarycolor,
                            height: 55,
                            wight: double.infinity),
                        Gap(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' لدي حساب؟',
                              style: getTextbady(),
                            ),
                            TextButton(
                              onPressed: () {
                                pushReplacement(
                                    context, LoginView(index: widget.index));
                              },
                              child: Text('سجل دخول',
                                  style: getTextbady(
                                      color: AppColor.primarycolor)),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}
