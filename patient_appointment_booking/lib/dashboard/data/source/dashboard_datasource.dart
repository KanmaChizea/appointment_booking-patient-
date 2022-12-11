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
    final id = await _cloudStorage
        .collection('appt ${appointment.patientId}')
        .add(appointment.toMap());
    await _cloudStorage
        .collection('appointments')
        .add(appointment.copyWith(id: id.id).toMap());
    return id.id;
  }

  Future<void> cancelAppointment(AppointmentEntity appointment) async {
    try {
      await _cloudStorage
          .collection('booked')
          .doc(appointment.date.replaceAll('/', '-'))
          .update({appointment.time: FieldValue.delete()});
      await _cloudStorage
          .collection('appt ${appointment.patientId}')
          .doc(appointment.id)
          .delete();
      final query = _cloudStorage
          .collection('appointments')
          .where('id', isEqualTo: appointment.id);
      query.get().then((value) => value.docs.forEach((element) {
            element.reference.delete();
          }));
    } catch (e) {
      print(e);
    }
  }

  Future<void> editProfile(UserData data) async {
    await _cloudStorage.collection('user data').doc(uid).set(data.toMap());
  }

  Stream<List<AppointmentEntity>> getActiveAppointment(String id) {
    return _cloudStorage.collection('appt $id').snapshots().map((value) => value
        .docs
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

  Future<List<AppointmentEntity>> getAppointmentHistory(String id) async {
    return await _cloudStorage.collection('appt $id').get().then((value) =>
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
