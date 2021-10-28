import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../model/photo.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/photos';

  static List<Photo> parsePhotos(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Photo> photos = list.map((model) => Photo.fromJson(model)).toList();
    return photos;
  }

  static Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri(path: url));
    if (response.statusCode == 200) {
      return compute(parsePhotos, response.body);
    } else {
      throw Exception('can\'t get photos');
    }
  }
}
