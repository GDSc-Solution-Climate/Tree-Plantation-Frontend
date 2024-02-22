import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:tree_plantation_frontend/api_url_constants.dart';

class AIServices {
  static Future textAiResponse(String promt) async {
    print('checking');
    print(promt);
    var response = await http.post(
      Uri.parse(textAi),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, String>{
        "prompt": promt,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      return Error();
    }
  }

  static Future<http.StreamedResponse> uploadImage({
    required Uint8List imageBytes,
    required String prompt,
    required String filePath, // Change this parameter name
  }) async {
    const String apiUrl = imageAi; // Assuming no username is required

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
    request.fields['prompt'] = prompt;

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
}
