import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String? id;
  final String date;
  final String time;
  final String patientId;
  final bool processed;
  //true for active, false for fulfilled
  final bool status;

  const AppointmentEntity({
    this.id,
    required this.date,
    required this.time,
    required this.patientId,
    required this.processed,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      id!,
    ];
  }

  AppointmentEntity copyWith({
    String? id,
    String? date,
    String? time,
    String? patientId,
    bool? processed,
    bool? status,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      patientId: patientId ?? this.patientId,
      processed: processed ?? this.processed,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'patientId': patientId,
      'processed': processed,
      'status': status,
    };
  }

  factory AppointmentEntity.fromMap(Map<String, dynamic> map) {
    return AppointmentEntity(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      processed: map['processed'] ?? false,
      patientId: map['patientId'] ?? '',
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentEntity.fromJson(String source) =>
      AppointmentEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentEntity(id: $id, date: $date, time: $time, patientId: $patientId, status: $status)';
  }
}
