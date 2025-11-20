import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraButton extends StatelessWidget {
 final Function(String imagePath) onImageCaptured;
  final String buttonText;

  const CameraButton({super.key, required this.onImageCaptured, required this.buttonText});

  Future<void> _takePhoto(BuildContext context) async {
    try {
      // req camera permit
      final status = await Permission.camera.request();

      if (status.isDenied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Camera permission is required to take photos'),
              backgroundColor: Colors.orange,
            )
          );
        }
        return;
      }

      // camera setting
      if (status.isPermanentlyDenied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Camera permission denied, please enable in settings'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Settings',
                onPressed: () => openAppSettings(),
              ),
            )
          );
        }
        return;
      }

      // allow camera and capture foto
      final ImagePicker picker = ImagePicker();
      // xfile => mendefinikan file yg berhubungan dgn apk.
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 70, // compressed image
      );

    // untuk ambil sesuai path foto
      if (photo != null) {
        onImageCaptured(photo.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking photo ${e.toString()}'),
            backgroundColor: Colors.red,
            ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _takePhoto(context),
      icon: Icon(Icons.camera_alt),
      label: Text(buttonText), 
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12
        )
      ),
    );
  }
}