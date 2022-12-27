import 'package:sharedmobileutilities/cloudinary/models/CloudinaryResponse.dart';
import 'data/ImageClient.dart';

class CloudinaryClient {
  ImageClient _client;
  String _apiSecret;
  String _cloudName;
  String _apiKey;

  CloudinaryClient(String apiKey, String apiSecret, String cloudName) {
    _apiKey = apiKey;
    _apiSecret = apiSecret;
    _cloudName = cloudName;
    _client = ImageClient(_apiKey, _apiSecret, _cloudName);
  }

  Future<CloudinaryResponse> uploadImage(String imagePath, {String filename, String folder}) async => _client.uploadImage(imagePath, imageFilename: filename, folder: folder);

  Future<CloudinaryResponse> uploadVideo(String videoPath, {String filename, String folder}) async => _client.uploadVideo(videoPath, videoFilename: filename, folder: folder);

  Future<List<CloudinaryResponse>> uploadImages(List<String> imagePaths, {String filename, String folder}) async {
    List<CloudinaryResponse> responses = [];
    for (var path in imagePaths) {
      CloudinaryResponse resp = await _client.uploadImage(path, imageFilename: filename, folder: folder);
      responses.add(resp);
    }
    return responses;
  }
}
