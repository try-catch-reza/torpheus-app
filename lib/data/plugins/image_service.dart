import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  Future<File?> pickFromCamera();
  Future<File?> pickFromGallery();
  Future<List<XFile>> pickMultipleFromGallery();
}