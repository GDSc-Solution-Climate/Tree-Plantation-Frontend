import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:tree_plantation_frontend/api_url_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tree_plantation_frontend/login.dart';

class UserServices {
  static Future createUser(
      String email, String password, String username) async {
    var res = await http.post(Uri.parse(createNewUser),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
          "username": username,
        }));
    print(res);
    if (res.statusCode == 201) {
      print(res);
      return jsonDecode(res.body);
    } else {
      return Error();
    }
  }

  static Future login(String userName, String password) async {
    var res = await http.get(Uri.parse("$loginUser$userName/$password"));
    print(res);
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    } else {
      return Error();
    }
  }

  static Future<List<dynamic>> getUserByName(String userName) async {
    var res = await http.get(Uri.parse("$getUser$userName"));
    if (res.statusCode == 200) {
      print(res.body);
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }

  static Future<http.StreamedResponse> addProfileImage({
    required Uint8List imageBytes,
    required String description,
    required String filePath, // Change this parameter name
  }) async {
    final String apiUrl =
        "$updateAvatar$userName"; // Assuming no username is required

    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));

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

  static Future putBioDetails(String userName, String bio) async {
    var res = await http.put(Uri.parse("$updateBio$userName"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{"bio": bio}));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Error();
    }
  }
}
