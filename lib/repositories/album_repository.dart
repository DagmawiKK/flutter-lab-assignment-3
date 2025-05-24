import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$_baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$_baseUrl/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<Photo>> fetchPhotosByAlbum(int albumId) async {
    final response = await http.get(Uri.parse('$_baseUrl/albums/$albumId/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album photos');
    }
  }
}