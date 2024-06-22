import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:universal_html/html.dart' as html;
import 'package:uuid/uuid.dart';

class ImageUploader {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  XFile? _webImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        _webImage = pickedFile;
      } else {
        _image = File(pickedFile.path);
      }
    }
  }

  Future<void> pickImageFromGallery() => _pickImage(ImageSource.gallery);
  Future<void> pickImageUsingCamera() => _pickImage(ImageSource.camera);

  Future<Uint8List?> _compressImage(File file) async {
    final rawImage = img.decodeImage(await file.readAsBytes());
    if (rawImage != null) {
      final compressedImage = img.encodeJpg(rawImage, quality: 85);
      return Uint8List.fromList(compressedImage);
    }
    return null;
  }

  Future<Uint8List?> _compressWebImage(XFile file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(html.File([await file.readAsBytes()], file.name));
    await reader.onLoad.first;

    final imageData = reader.result as Uint8List;
    final rawImage = img.decodeImage(imageData);
    if (rawImage != null) {
      final compressedImage = img.encodeJpg(rawImage, quality: 85);
      return Uint8List.fromList(compressedImage);
    }
    return null;
  }

  Future<String?> uploadFile() async {
    if (_image == null && _webImage == null) return null;
    try {
      final uuid = const Uuid().v4();
      final fileName = '$uuid.jpg';
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      Uint8List? compressedImage;
      if (kIsWeb && _webImage != null) {
        compressedImage = await _compressWebImage(_webImage!);
      } else if (_image != null) {
        compressedImage = await _compressImage(_image!);
      }

      if (compressedImage != null) {
        await storageRef.putData(compressedImage);
        final downloadUrl = await storageRef.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
