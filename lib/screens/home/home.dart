import 'package:flutter_trabalho4_opta1/commons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLabels.appBarHome),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentScreen()),
            );
          },
          child: const Text(AppLabels.addAppointments),
        ),
      ),
    );
  }
}
