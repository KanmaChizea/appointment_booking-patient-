import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/data/model/userdata_model.dart';
import '../../../auth/domain/entitis/user_data.dart';
import '../../domain/entities/appontments.dart';
import '../models/appointment_model.dart';

class DashboardDataSource {
  final _cloudStorage = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  Future<String> bookAppointment(AppointmentEntity appointment) async {
    await _cloudStorage
        .collection('booked')
        .doc(appointment.date.replaceAll('/', '-'))
        .set({appointment.time: appointment.time}, SetOptions(merge: true));
    final id =
        await _cloudStorage.collection('appt $uid').add(appointment.toMap());
    await _cloudStorage.collection('appointments').add(
        appointment.copyWith(id: id.id.substring(0, 10).toUpperCase()).toMap());
    return id.id;
  }

  Future<void> cancelAppointment(AppointmentEntity appointment) async {
    await _cloudStorage.collection('appt $uid').doc(appointment.id).delete();
  }

  Future<void> editProfile(UserData data) async {
    await _cloudStorage.collection('user data').doc(uid).set(data.toMap());
  }

  Stream<List<AppointmentEntity>> getActiveAppointment() {
    return _cloudStorage.collection('appt $uid').snapshots().map((value) =>
        value.docs
            .map((e) => AppointmentModel.fromFirebase(e).toEntity())
            .where((element) => element.status == true)
            .toList());
  }

  Stream<UserData> fetchData(String id) {
    return _cloudStorage
        .collection('user data')
        .doc(id)
        .snapshots()
        .map((value) => UserDataModel.fromFirebase(value).toEntity());
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
    await _cloudStorage
        .collection('booked')
        .doc(date.replaceAll('/', '-'))
        .get()
        .then((value) => value
            .data()
            ?.values
            .forEach((element) => list.add(element.toString())));
    return list;
  }
}
