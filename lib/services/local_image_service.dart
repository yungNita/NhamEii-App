import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class LocalImageService {
  static Future<String> _getUserImagePath(String userId) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/profile_${userId}_v2.jpg'; // Added version
  }

  static Future<File?> saveProfileImage(String userId, File image) async {
    try {
      final path = await _getUserImagePath(userId);
      print('Saving profile image to: $path');
      
      // Delete old image if exists
      await deleteProfileImage(userId);
      
      // Compress image before saving
      final compressedImage = await _compressImage(image);
      
      // Save new image
      final savedFile = await compressedImage.copy(path);
      print('Profile image saved successfully');
      return savedFile;
    } catch (e) {
      print('Error saving profile image: $e');
      return null;
    }
  }

  static Future<File> _compressImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      final compressedImage = img.encodeJpg(decodedImage!, quality: 85);
      
      // Create temp file for compressed image
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      return File(tempPath)..writeAsBytesSync(compressedImage);
    } catch (e) {
      print('Error compressing image: $e');
      return imageFile; // Return original if compression fails
    }
  }

  static Future<File?> getProfileImage(String userId) async {
    try {
      final path = await _getUserImagePath(userId);
      print('Loading profile image from: $path');
      final file = File(path);
      final exists = await file.exists();
      print('File exists: $exists');
      return exists ? file : null;
    } catch (e) {
      print('Error getting profile image: $e');
      return null;
    }
  }

  static Future<void> deleteProfileImage(String userId) async {
    try {
      final path = await _getUserImagePath(userId);
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        print('Deleted old profile image');
      }
    } catch (e) {
      print('Error deleting profile image: $e');
    }
  }
}