import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:torpheus/data/plugins/image_service.dart';

class ImageServiceImpl extends ImageService {
  final ImagePicker _picker = ImagePicker();

  ImageServiceImpl();

  @override
  Future<File?> pickFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    return image != null ? File(image.path) : null;
  }

  @override
  Future<File?> pickFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  @override
  Future<List<XFile>> pickMultipleFromGallery() async {
    return await _picker.pickMultiImage();
  }
}
