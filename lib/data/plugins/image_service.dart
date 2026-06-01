import 'dart:io';

abstract class ImageService {
  Future<File?> pickFromCamera();
  Future<File?> pickFromGallery();
}