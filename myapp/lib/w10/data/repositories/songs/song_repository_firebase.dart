import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'flutterpanha-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );


  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs() async {
    if (_cachedSongs != null) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
  
  }

  @override
  void clearCache() {
    _cachedSongs = null;
  }
  
  @override
  Future<void> updateLikeAmount (String songId, int newLikeAmount) async{
    try {
      final Uri updateUri = Uri.https(
        'flutterpanha-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/songs/$songId.json',
      );
      final http.Response response = await http.patch(
        updateUri,
        body: json.encode({'likeAmount': newLikeAmount}),
      );
      if (response.statusCode == 200) {
        clearCache();
      } else {
        print("Update failed Status: ${response.statusCode} Body: ${response.body}");
        throw Exception('Failed to update like amount: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating like amount: $e');
      rethrow;
    }
  }
}
