import 'package:flutter_trabalho4_opta1/commons.dart';

class FirestoreService {
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addAppointment(Appointment appointment) async {
    await appointmentsCollection.doc(appointment.id).set(appointment.toMap());
  }

  Future<List<Appointment>> getAppointmentsForDate(
      String ubsName, String specialty, DateTime date) async {
    QuerySnapshot querySnapshot = await appointmentsCollection
        .where('ubsName', isEqualTo: ubsName)
        .where('specialty', isEqualTo: specialty)
        .where('date', isEqualTo: date.toIso8601String())
        .get();

    return querySnapshot.docs
        .map((doc) => Appointment.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
