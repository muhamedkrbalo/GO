import 'package:file_picker/file_picker.dart';

typedef PickedDocumentFile = ({String name, int sizeInBytes, String? path});

class DocumentPickerMethods {
  const DocumentPickerMethods._();

  static const allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];
  static const maxSizeInBytes = 10 * 1024 * 1024;

  static Future<PickedDocumentFile?> pickDocument() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (file == null) return null;
    final sizeInBytes = file.lengthSync() ?? await file.length();
    return (name: file.name, sizeInBytes: sizeInBytes, path: file.path);
  }
}
