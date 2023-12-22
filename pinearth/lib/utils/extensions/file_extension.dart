import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

extension FileExtension on File {
  Future<String> toBase64() async {
    return await imageToBase64(this);
  }
}

Future<String> imageToBase64(File file) async {
  // Read the image file as bytes
  List<int> imageBytes = await File(file.path).readAsBytes();

  // Convert the bytes to Base64
  String base64Image = base64Encode(Uint8List.fromList(imageBytes));

  return base64Image;
}