import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/presentation/data/doctor_model.dart';
import 'package:se7ety/features/auth/presentation/view_model/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitStates());

  //register as patient
  createUserWithEmailAndPassword(
      String name, String email, String password) async {
    emit(RegisterLoadingStates());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('patient').doc(user.uid).set({
        'name': name,
        'email': email,
        'image': '',
        'phone': '',
        'bio': '',
        'city': '',
        'age': '',
      }, SetOptions(merge: true));//قابل للتعديل
      emit(RegisterSuccessStates());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorStates(error: 'كلمه المرور ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorStates(error: 'الحساب موجود بالفعل'));
      } else {
        emit(RegisterErrorStates(error: 'حدثت مشكله ف التسجيل'));
      }
    }
  }

  //register as doctor
  createdoctorWithEmailAndPassword(
      String name, String email, String password) async {
    emit(RegisterLoadingStates());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('doctor').doc(user.uid).set({
        'name': name,
        'email': email,
        'image': '',
        'Specialization': '',
        'phone': '',
        'phone2': '',
        'bio': '',

        'openHour': '',
        'closeHour': '',
        'address': '',
      }, SetOptions(merge: true)) ;//قابل للتعديل
      emit(RegisterSuccessStates());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorStates(error: 'كلمه المرور ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorStates(error: 'الحساب موجود بالفعل'));
      } else {
        emit(RegisterErrorStates(error: 'حدثت مشكله ف التسجيل'));
      }
    }
  }
  // /Uplouddoctor
  Uplouddoctor(DoctorModel doctor )
  async {
    emit(UploudDoctorDataLoadingStates());
    try {

      FirebaseFirestore.instance.collection('doctor').doc(doctor.id).set({

        'image': doctor.image,
        'Specialization': doctor.specialization,
        'phone': doctor.phone1,
        'phone2': doctor.phone2,
        'bio': doctor.bio,
        'rating':doctor.rating,
        'openHour': doctor.openHour,
        'closeHour': doctor.closeHour,
        'address': doctor.address,
      }, SetOptions(merge: true)) ;//قابل للتعديل
      emit(UploudDoctorDataSuccessStates());
    } catch(e){
      emit(UploudDoctorDataErrorStates(error: 'حدثت مشكله حاول لاحقا'));
    }
  }
Login(String email, String password) async {
  try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
        
    );
    emit(LoginSuccessStates());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
     emit(LoginErrorStates(error: 'الحساب غير موجود'));
    } else if (e.code == 'wrong-password') {
      emit(LoginErrorStates(error: 'كلمه السر خاطئه'));
    }
  }
}


}


