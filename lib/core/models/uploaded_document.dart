import 'package:equatable/equatable.dart';

class UploadedDocument extends Equatable {
  const UploadedDocument({required this.name, required this.sizeInBytes, this.path});

  final String name;
  final int sizeInBytes;
  final String? path;

  String get sizeLabel {
    const kb = 1024;
    if (sizeInBytes < kb * kb) return '${(sizeInBytes / kb).ceil()} KB';
    return '${(sizeInBytes / (kb * kb)).toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [name, sizeInBytes, path];
}
