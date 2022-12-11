import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/appontments.dart';

class AppointmentModel extends Equatable {
  final String id;
  final String date;
  final String time;
  final String patientId;
  final bool processed;
  //true for active, false for fulfilled
  final bool status;
  const AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.patientId,
    required this.processed,
    required this.status,
  });

  factory AppointmentModel.fromFirebase(DocumentSnapshot snapshot) =>
      AppointmentModel(
          id: snapshot.id,
          date: snapshot['date'],
          time: snapshot['time'],
          patientId: snapshot['patientId'],
          processed: snapshot['processed'],
          status: snapshot['status']);

  AppointmentEntity toEntity() => AppointmentEntity(
      id: id,
      date: date,
      time: time,
      patientId: patientId,
      processed: processed,
      status: status);

  @override
  List<Object?> get props => [id];
}
