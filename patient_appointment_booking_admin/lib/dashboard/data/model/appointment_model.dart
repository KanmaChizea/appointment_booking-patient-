import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/appontments.dart';

class AppointmentModel extends Equatable {
  final String id;
  final String date;
  final String time;
  final String patientId;
  //true for active, false for fulfilled
  final bool status;
  const AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.patientId,
    required this.status,
  });

  factory AppointmentModel.fromFirebase(DocumentSnapshot snapshot) =>
      AppointmentModel(
          id: snapshot['id'],
          date: snapshot['date'],
          time: snapshot['time'],
          patientId: snapshot['patientId'],
          status: snapshot['status']);

  AppointmentEntity toEntity() => AppointmentEntity(
      id: id, date: date, time: time, patientId: patientId, status: status);

  @override
  List<Object?> get props => [id];
}
