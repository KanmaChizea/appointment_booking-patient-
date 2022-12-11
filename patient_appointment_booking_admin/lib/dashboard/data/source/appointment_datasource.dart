import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:patient_appointment_booking_admin/dashboard/data/model/user_model.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/entity/user_entity.dart';
import '../model/appointment_model.dart';

import '../../domain/entity/appontments.dart';

class AppointmentDataSource {
  final _dbase = FirebaseFirestore.instance;

  Stream<List<AppointmentEntity>> getAllAppointments() {
    final list = _dbase.collection('appointments').snapshots().map((event) =>
        event.docs
            .map((e) => AppointmentModel.fromFirebase(e).toEntity())
            .toList()
          ..removeWhere((element) {
            return DateFormat('MM/dd/yyyy').parse(element.date).day !=
                DateTime.now().day;
          }));

    return list;
  }

  Future<void> markAsFulfilled(AppointmentEntity appointment) async {
    await _dbase
        .collection('appointments')
        .doc(appointment.docid)
        .update(appointment.copyWith(status: !appointment.status).toMap());
    await _dbase
        .collection('appt ${appointment.patientId}')
        .doc(appointment.id)
        .update(appointment.copyWith(status: !appointment.status).toMap());
  }

  Future<void> markAsProcessed(AppointmentEntity appointment) async {
    await _dbase.collection('appointments').doc(appointment.docid).update(
        appointment.copyWith(processed: !appointment.processed).toMap());
    await _dbase
        .collection('appt ${appointment.patientId}')
        .doc(appointment.id)
        .update(
            appointment.copyWith(processed: !appointment.processed).toMap());
  }

  Stream<List<UserData>> getUser() {
    return _dbase.collection('user data').snapshots().map((event) => event.docs
        .map((e) => UserDataModel.fromFirebase(e).toEntity())
        .toList());
  }
}
