import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  String? path;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Use file_selector for desktop platforms
    final XFile? file = await openFile(
      acceptedTypeGroups: [
        const XTypeGroup(label: 'Images', extensions: ['jpg', 'png', 'gif'])
      ],
    );
    path = file?.path;
  } else {
    // Use image_picker for mobile platforms
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    path = pickedFile?.path;
  }

  return path;
}
