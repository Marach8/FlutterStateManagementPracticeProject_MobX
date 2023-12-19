import 'dart:io';

typedef ImageID = String;


abstract class ImageUploadService {
  Future<ImageID?> uploadImage({
    required String filePath, required String userId, required String imageId
  });
}

