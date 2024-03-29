import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:tree_plantation_frontend/api_url_constants.dart';
import 'package:tree_plantation_frontend/login.dart';

class ImageUploadService {
  static Future<http.StreamedResponse> uploadImage({
    required Uint8List imageBytes,
    required String description,
    required String filePath, // Change this parameter name
  }) async {
    final String apiUrl =
        "$uploadTreeImage$userName"; // Assuming no username is required

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Attach the image file to the request
    var stream = http.ByteStream.fromBytes(imageBytes);
    var multipartFile = http.MultipartFile(
      'filePath', // Change the field name to match Postman
      stream,
      imageBytes.length,
      filename: basename(filePath), // Use the actual file name
      contentType: getMediaType(filePath),
    );
    request.files.add(multipartFile);

    // Add description to FormData
    request.fields['desc'] = description;

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    return response;
  }

  static MediaType getMediaType(String fileName) {
    String fileExtension = extension(fileName).replaceAll('.', '');
    switch (fileExtension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      // Add more cases for other file types if needed
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  static Future<http.StreamedResponse> uploadChildImage({
    required Uint8List imageBytes,
    required String description,
    required String filePath,
    required String imgId,
  }) async {
    final String apiUrl =
        "$createChildImage$userName/$imgId"; // Assuming no username is required
    print(apiUrl);
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Attach the image file to the request
    var stream = http.ByteStream.fromBytes(imageBytes);
    var multipartFile = http.MultipartFile(
      'filePath', // Change the field name to match Postman
      stream,
      imageBytes.length,
      filename: basename(filePath), // Use the actual file name
      contentType: getMediaType(filePath),
    );
    request.files.add(multipartFile);

    // Add description to FormData
    request.fields['desc'] = description;

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    return response;
  }
}
