import 'dart:io';

import 'package:mobx_practice_course/providers/image_upload_provider.dart';

class MockImageUploadService implements ImageUploadService{
  @override
  Future<ImageID?> uploadImage({
    required String filePath, required String userId, required String imageId
  }) async => Future.value('mock_image_ID');
}