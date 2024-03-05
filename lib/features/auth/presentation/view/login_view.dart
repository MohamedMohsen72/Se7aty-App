import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';
import 'package:se7ety/core/function/emailvalidate.dart';
import 'package:se7ety/core/function/push_pop_function.dart';
import 'package:se7ety/core/widget/custom_dialoges.dart';
import 'package:se7ety/core/widget/custombotton.dart';
import 'package:se7ety/features/auth/presentation/view/signup_view.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_qubit.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_states.dart';
import 'package:se7ety/features/patient/presentation/view/navbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
        if (state is LoginSuccessStates) {
          pushAndRemoveUntil(context, const NavBar());
        } else if (state is LoginErrorStates) {
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
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'هل نسيت كلمه السر؟',
                          style: getTextbady(fontSize: 15),
                        ),
                      ],
                    ),
                    Gap(25),
                    CustomElevatedButton(
                        text: 'تسجل دخول',
                        style: getTextTitle(
                            fontSize: 24, color: AppColor.whiteColor),
                        radius: 25,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<AuthCubit>().Login(
                                  emailController.text,
                                  passwordController.text,
                                );

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
                          'ليس لدي حساب؟',
                          style: getTextbady(),
                        ),
                        TextButton(
                          onPressed: () {
                            pushReplacement(
                                context, RegisterView(index: widget.index));
                          },
                          child: Text('سجل الان',
                              style: getTextbady(color: AppColor.primarycolor)),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}
