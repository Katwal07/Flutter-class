import 'package:digital_pathshala_batch/controller/image_picker_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/create_profile_controller.dart';
import '../model/create_profile_model.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _dob = '';
  bool isChecked = false;

  VehicleModel? selectedVehicle;

  final controller = Get.put(CreateProfileController());
  final imageController = Get.put(ImagePickerController());

  final List<VehicleModel> vehicles = [
    VehicleModel(id: '1', name: 'Car'),
    VehicleModel(id: '2', name: 'Bike'),
    VehicleModel(id: '3', name: 'Scotter'),
  ];

  @override
  void dispose() {
    _datePickerController.dispose();
    _genderController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();
    _phoneNumberController.dispose();
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
              Obx(() {
                return GestureDetector(
                  onTap: imageController.pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: CupertinoColors.systemGrey6,
                        child: ClipOval(
                          child: imageController.pickedImage.value != null
                              ? Image.file(
                                  imageController.pickedImage.value!,
                                  width: 138,
                                  height: 138,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/background_light_image.png',
                                  width: 138,
                                  height: 138,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      if (imageController.isLoading.value)
                        // Position -> Parent Widget -> Ko Posititon Track
                        ///  top , bottom , left, right
                        const Positioned(
                          bottom: 0,
                          right: 12,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        ),
                      if (!imageController.isLoading.value)
                        const Positioned(
                          bottom: 0,
                          right: 12,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 16,
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Full Name"),
              ),
              TextFormField(
                controller: _nickNameController,
                decoration: InputDecoration(hintText: "Nick Name"),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(hintText: "Phone Number"),
              ),

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
                    isChecked = value;
                  });
                },
              ),

              ElevatedButton(
                onPressed: () async {
                  final model = CreateProfileModel(
                    id: "b30625e9-ac5e-4aeb-b864-5dd374330cca",
                    fullName: "rohankatwal55@gmail.com",
                    nickName: "Rohan",
                    dateOfBirth: "1990-01-01",
                    phoneNumber: "+977-9804979923",
                    gender: "MALE",
                    profileImage: imageController.pickedImage.value?.path,
                  );

                  await controller.createProfile(model);

                  if (controller.isSuccess.value) {
                    Get.snackbar("Success", "Profile created successfully");
                  } else if (controller.errorMessage.value.isNotEmpty) {
                    Get.snackbar("Error", controller.errorMessage.value);
                  }
                },
                child: Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Create Profile"),
                ),
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
