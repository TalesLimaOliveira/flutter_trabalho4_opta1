class Appointment {
  String id;
  String patientName;
  String ubsName;
  String specialty;
  DateTime date;

  Appointment({
    required this.id,
    required this.patientName,
    required this.ubsName,
    required this.specialty,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientName': patientName,
      'ubsName': ubsName,
      'specialty': specialty,
      'date': date.toIso8601String(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      patientName: map['patientName'],
      ubsName: map['ubsName'],
      specialty: map['specialty'],
      date: DateTime.parse(map['date']),
    );
  }
}
