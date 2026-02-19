import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  var pickedImage = Rx<File?>(null);
  var isLoading = false.obs;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    isLoading.value = true;

    // PermissionStatus status = await Permission.photos.request();
    // if (!status.isGranted) {
    //   isLoading.value = false;
    //   if (status.isPermanentlyDenied) {
    //     //await openAppSettings();
    //   }
    //   return;
    // }

    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      final bytes = await file.length();
      if (bytes > 2 * 1024 * 1024) {
        // Show some toast / error if needed
        isLoading.value = false;
        return;
      }
      pickedImage.value = file;
    }

    isLoading.value = false;
  }
}
