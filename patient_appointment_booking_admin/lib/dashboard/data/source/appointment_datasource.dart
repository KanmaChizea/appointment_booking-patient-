import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_appointment_booking_admin/dashboard/data/model/appointment_model.dart';

import '../../domain/entity/appontments.dart';

class AppointmentDataSource {
  final _dbase = FirebaseFirestore.instance;

  Stream<List<AppointmentEntity>> getAllAppointments() {
    final list = _dbase.collection('appointments').snapshots().map((event) =>
        event.docs
            .map((e) => AppointmentModel.fromFirebase(e).toEntity())
            .toList()
          ..removeWhere((element) =>
              DateTime.parse(element.date).isBefore(DateTime.now())));

    return list;
  }

  Future<void> markAsFulfilled(AppointmentEntity appointment) async {
    await _dbase
        .collection('appt ${appointment.patientId}')
        .doc(appointment.id)
        .update(appointment.copyWith(status: false).toMap());
  }
}
