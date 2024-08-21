// ignore_for_file: use_build_context_synchronously

import 'package:flutter_trabalho4_opta1/commons.dart';

class AppointmentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  String _selectedUbs = '';
  String _selectedSpecialty = '';
  DateTime _selectedDate = DateTime.now();

  AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentController = Provider.of<AppointmentController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppLabels.addAppointments)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _patientNameController,
                decoration: const InputDecoration(labelText: AppLabels.patientName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLabels.valueError;
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedUbs,
                onChanged: (value) {
                  _selectedUbs = value!;
                },
                items: appointmentController.ubsList.map((String ubs) {
                  return DropdownMenuItem<String>(
                    value: ubs,
                    child: Text(ubs),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: AppLabels.ubs),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSpecialty,
                onChanged: (value) {
                  _selectedSpecialty = value!;
                },
                items: appointmentController.specialtyList.map((String specialty) {
                  return DropdownMenuItem<String>(
                    value: specialty,
                    child: Text(specialty),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: AppLabels.specialty),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: AppLabels.date),
                controller: TextEditingController(text: _selectedDate.toString()),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _selectedDate = pickedDate;
                  }
                },
              ),

              const SizedBox(width: 10.0),
              
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool success = await appointmentController.addAppointment(
                      _patientNameController.text,
                      _selectedUbs,
                      _selectedSpecialty,
                      _selectedDate,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(AppLabels.successMark)),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(AppLabels.errorLimit)),
                      );
                    }
                  }
                },
                child: const Text(AppLabels.addAppointments),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
