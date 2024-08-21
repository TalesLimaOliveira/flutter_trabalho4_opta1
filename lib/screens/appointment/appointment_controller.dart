import 'package:flutter_trabalho4_opta1/commons.dart';

class AppointmentController with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> ubsList = ['UBS 1', 'UBS 2', 'UBS 3'];  // Pode ser substituído por dados do Firestore
  final List<String> specialtyList = ['Cardiology', 'Dentistry', 'Pediatrics'];  // Pode ser substituído por dados do Firestore

  Future<bool> addAppointment(String patientName, String ubsName, String specialty, DateTime date) async {
    List<Appointment> existingAppointments = await _firestoreService.getAppointmentsForDate(ubsName, specialty, date);

    if (existingAppointments.length >= 20) {
      return false;
    }

    final newAppointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientName: patientName,
      ubsName: ubsName,
      specialty: specialty,
      date: date,
    );

    await _firestoreService.addAppointment(newAppointment);
    return true;
  }
}
