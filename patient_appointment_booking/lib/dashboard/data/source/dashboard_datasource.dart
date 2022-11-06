import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patient_appointment_booking/dashboard/data/models/appointment_model.dart';

import '../../../auth/domain/entitis/user_data.dart';
import '../../domain/entities/appontments.dart';

class DashboardDataSource {
  final _cloudStorage = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  Future<String> bookAppointment(AppointmentEntity appointment) async {
    final id =
        await _cloudStorage.collection('appt $uid').add(appointment.toMap());
    await _cloudStorage
        .collection('booked')
        .doc(appointment.date)
        .set({Random().toString(): appointment.time});
    return id.id;
  }

  Future<void> cancelAppointment(AppointmentEntity appointment) async {
    await _cloudStorage.collection('appt $uid').doc(appointment.id).delete();
  }

  Future<void> editProfile(UserData data) async {
    await _cloudStorage.collection('user data').doc(uid).set(data.toMap());
  }

  Future<List<AppointmentEntity>> getActiveAppointment() async {
    return await _cloudStorage.collection('appt $uid').get().then((value) =>
        value.docs
            .map((e) => AppointmentModel.fromFirebase(e).toEntity())
            .where((element) => element.status == true)
            .toList());
  }

  Future<List<AppointmentEntity>> getAppointmentHistory() async {
    return await _cloudStorage.collection('appt $uid').get().then((value) =>
        value.docs
            .map((e) => AppointmentModel.fromFirebase(e).toEntity())
            .where((element) => element.status == false)
            .toList());
  }

  Future<List<String>> getBookedTimes(String date) async {
    List<String> list = [];
    await _cloudStorage.collection('booked').doc(date).get().then((value) =>
        value
            .data()
            ?.values
            .forEach((element) => list.add(element.toString())));
    return list;
  }
}
