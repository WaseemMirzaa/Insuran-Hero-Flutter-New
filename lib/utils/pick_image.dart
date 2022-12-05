import 'dart:io';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source, imageQuality: 50);
  if (_file != null) {
    return await File(_file.path);
  }
  print('No Image Selected');
}
