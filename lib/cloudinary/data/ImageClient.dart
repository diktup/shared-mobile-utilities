import 'package:flutter/material.dart';
import 'package:sharedmobileutilities/cloudinary/models/CloudinaryResponse.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'BaseApi.dart';

class ImageClient extends BaseApi {
  String _cloudName;
  String _apiKey;
  String _apiSecret;

  ImageClient(String apiKey, String apiSecret, String cloudName) {
    _apiKey = apiKey;
    _apiSecret = apiSecret;
    _cloudName = cloudName;
  }

  Future<CloudinaryResponse> uploadImage(String imagePath, {String imageFilename, String folder}) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> params = {};
    if (_apiKey == null) {
      throw Exception("apiKey and apiSecret must not be null");
    }

    params["api_key"] = _apiKey;

    if (imagePath == null) {
      throw Exception("imagePath must not be null");
    }
    String publicId = imagePath.split('/').last;
    publicId = publicId.split('.')[0];

    if (imageFilename != null) {
      publicId = imageFilename.split('.')[0];
    } else {
      imageFilename = publicId;
    }

    params["folder"] = folder;

    params["public_id"] = publicId;

    params["file"] = await MultipartFile.fromFile(imagePath, filename: imageFilename);
    params["timestamp"] = timeStamp;

    params["signature"] = getSignature(folder, publicId, timeStamp);

    FormData formData = FormData.fromMap(params);

    Dio dio = await getApiClient();
    Response response = await dio.post("$_cloudName/image/upload", data: formData);
    try {
      return CloudinaryResponse.fromJsonMap(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return CloudinaryResponse.fromError("$error");
    }
  }

  Future<CloudinaryResponse> uploadVideo(String videoPath, {String videoFilename, String folder}) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> params = {};
    if (_apiKey == null) {
      throw Exception("apiKey and apiSecret must not be null");
    }

    params["api_key"] = _apiKey;

    if (videoPath == null) {
      throw Exception("videoPath must not be null");
    }
    String publicId = videoPath.split('/').last;
    publicId = publicId.split('.')[0];

    if (videoFilename != null) {
      publicId = videoFilename.split('.')[0];
    } else {
      videoFilename = publicId;
    }

    params["folder"] = folder;

    params["public_id"] = publicId;

    params["file"] = await MultipartFile.fromFile(videoPath, filename: videoFilename);
    params["timestamp"] = timeStamp;
    params["signature"] = getSignature(folder, publicId, timeStamp);

    FormData formData = FormData.fromMap(params);

    Dio dio = await getApiClient();
    Response response = await dio.post("$_cloudName/video/upload", data: formData);
    try {
      return CloudinaryResponse.fromJsonMap(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return CloudinaryResponse.fromError("$error");
    }
  }

  String getSignature(String folder, String publicId, int timeStamp) {
    var buffer = StringBuffer();
    buffer.write("folder=$folder&");
    buffer.write("public_id=$publicId&");
    buffer.write("timestamp=$timeStamp$_apiSecret");

    var bytes = utf8.encode(buffer.toString().trim());

    return sha1.convert(bytes).toString();
  }
}
