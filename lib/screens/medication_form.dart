import 'package:flutter/material.dart';
//import 'package:input_quantity/input_quantity.dart';
import 'medication_screen.dart';

class MedicationFormScreen extends StatefulWidget {
  final Function(Medication) onMedicationAdded;
  const MedicationFormScreen({
    super.key,
    required this.onMedicationAdded,
  });

  @override
  _MedicationFormScreenState createState() => _MedicationFormScreenState();
}

class _MedicationFormScreenState extends State<MedicationFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  int selectedQuantity = 1;
  String selectedFrequency = '1x daily';
  List<String> selectedInstructions = [];

  List<int> quantityOptions = [1, 2, 3, 4];
  List<String> frequencyOptions = [
    '1x daily',
    '2x daily',
    '3x daily',
  ];

  List<String> intakeInstructions = [
    'on empty stomach',
    'before breakfast',
    'after breakfast',
    'before lunch',
    'after lunch',
    'before dinner',
    'after dinner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Medication'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4, // Adds a shadow to the card
            margin:
                EdgeInsets.only(bottom: 10), // Provides spacing below the card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Medication Name',
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Quantity ',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  DropdownButtonFormField(
                    value: selectedQuantity,
                    items: quantityOptions.map((int option) {
                      return DropdownMenuItem<int>(
                        child: Text(option.toString()),
                        value: option,
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuantity = value ?? 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'How often is this medication taken?',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  DropdownButtonFormField(
                    value: selectedFrequency,
                    items: frequencyOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        child: Text(option),
                        value: option,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedFrequency = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Choose Intake Instructions that apply:',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  Column(
                    children: intakeInstructions.map((instruction) {
                      return CheckboxListTile(
                        title: Text(instruction),
                        value: selectedInstructions.contains(instruction),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedInstructions.add(instruction);
                            } else {
                              selectedInstructions.remove(instruction);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              final String name = _nameController.text;

              if (name.isNotEmpty) {
                final newMedication = Medication(
                  name: name,
                  quantity: selectedQuantity,
                  frequency: selectedFrequency,
                  intakeInstructions: selectedInstructions,
                );
                widget.onMedicationAdded(newMedication);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18),
            ),
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(Size(150, 0)), // Set the width here
              padding: MaterialStateProperty.all(
                  EdgeInsets.all(15.0)), // Optional: Adjust padding
            ),
          ),
        ),
      ],
    );
  }
}