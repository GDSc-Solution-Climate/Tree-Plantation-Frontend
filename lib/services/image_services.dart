import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tree_plantation_frontend/api_url_constants.dart';

class ImageServices {
  static Future getImagesById(String username) async {
    var res = await http.get(Uri.parse("$findImagesForUser$username"));
    if (res.statusCode == 200) {
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }

  static Future getImgById(String imgId) async {
    var res = await http.get(Uri.parse("$getImageDetailsById$imgId"));
    if (res.statusCode == 200) {
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }

  static Future likeImage(String user, String imgId) async {
    var res = await http.post(
      Uri.parse(addLike),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{"userId": user, "imageId": imgId}),
    );
    if (res.statusCode == 200) {
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }

  static Future getAllImages() async {
    print('checking');
    var res = await http.get(Uri.parse(allImages));
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    } else {
      return [Error()];
    }
  }

  static Future replyToPost(String user, String imgId, String reply) async {
    var res = await http.post(
      Uri.parse(addReply),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          <String, dynamic>{"userId": user, "imageId": imgId, "text": reply}),
    );
    if (res.statusCode == 200) {
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }

  static Future getChildImage(String userId, String imgId) async {
    print('$childImages/$userId/$imgId');
    var res = await http.get(Uri.parse('$childImages$userId/$imgId'));
    if (res.statusCode == 200) {
      return [jsonDecode(res.body)];
    } else {
      return [Error()];
    }
  }
}
