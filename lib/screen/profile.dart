import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehicleModel {
  final String id;
  final String name;

  VehicleModel({required this.id, required this.name});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _datePickerController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String _dob = '';
  bool isChecked = false;

  VehicleModel? selectedVehicle;

  final List<VehicleModel> vehicles = [
    VehicleModel(id: '1', name: 'Car'),
    VehicleModel(id: '2', name: 'Bike'),
    VehicleModel(id: '3', name: 'Scotter'),
  ];

  @override
  void dispose() {
    _datePickerController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// DateTime Picker.
              // CustomTextField(
              //   controller: _datePickerController,
              //   label: "Date Time",
              //   prefixIcon: Icons.date_range,
              //   keyboardType: TextInputType.datetime,
              // ),
              TextFormField(
                controller: _datePickerController,
                onTap: () => _showDOBDatePicker(context),
                readOnly: true,
                decoration: InputDecoration(hintText: "Pick Date"),
              ),
              TextFormField(
                controller: _genderController,
                onTap: () => _showGenderPicker(context),
                readOnly: true,
                decoration: InputDecoration(hintText: "Select Gender"),
              ),

              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),

              DropdownButtonFormField(
                value: selectedVehicle,
                decoration: InputDecoration(
                  labelText: 'Select Vehicle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),

                // items: [
                //   DropdownMenuItem(child: Text("HI")),
                //   DropdownMenuItem(child: Text("Hello")),
                //   DropdownMenuItem(child: Text("Buye")),
                //   DropdownMenuItem(child: Text("data")),
                // ],
                items: vehicles
                    .map(
                      (vehicle) => DropdownMenuItem(
                        value: vehicle,
                        child: Text(vehicle.name),
                      ),
                    )
                    .toList(),
                onChanged: (vehicle) {
                  setState(() {
                    selectedVehicle = vehicle;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a vehicle' : null,
              ),

              CupertinoSwitch(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDOBDatePicker(BuildContext context) async {
    /// DateTime -> Object.(-10)
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1915),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 19)),
      builder: (context, child) {
        return Dialog(
          backgroundColor: Colors.blue,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: SizedBox(
            width: 300,
            height: 500,
            child: Theme(
              data: Theme.of(context).copyWith(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                colorScheme: ColorScheme.light(
                  primary: Colors.blue,
                  secondary: Colors.green,
                ),
                textTheme: Theme.of(context).textTheme.copyWith(
                  headlineLarge: const TextStyle(fontSize: 1),
                  titleLarge: const TextStyle(),
                  bodyLarge: TextStyle(),
                  bodyMedium: TextStyle(),
                  labelLarge: TextStyle(),
                ),
              ),
              child: child!,
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dob = picked.toIso8601String().split('T')[0];
        _datePickerController.text = _dob;
      });
    }
  }

  void _showGenderPicker(BuildContext context) async {
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      position: RelativeRect.fromLTRB(20, 100, 0, 0),
      color: Colors.white,
      items: [
        PopupMenuItem(value: "MALE", child: Text("Male")),
        PopupMenuItem(value: "FEMALE", child: Text("Female")),
        PopupMenuItem(value: "OTHERS", child: Text("Others")),
      ],
    ).then((value) {
      if (value != null) {
        _genderController.text = value;
      }
    });
  }
}
