import 'dart:io';
import 'package:camera_118/camera_page.dart';
import 'package:camera_118/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> _takePicture() async {
    await _requestPermissions();
    final File? result = await Navigator.push<File>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );
    if (result == null) {
      final saved = await StorageHelper.saveImage(result!, 'camera');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Disimpan: ${saved.path}')));
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final saved = await StorageHelper.saveImage(File(picked.path), 'gallery');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Disalin: ${saved.path}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
