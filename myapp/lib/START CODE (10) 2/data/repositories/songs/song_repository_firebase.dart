import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.https('flutterpanha-default-rtdb.asia-southeast1.firebasedatabase.app');
  static final Uri songsUri= baseUri.replace(path: '/songs.json');

  @override
  Future<List<Song>> fetchSongs() async {
    print(songsUri);
    final http.Response response = await http.get(songsUri);
    print(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String,dynamic>  songJson = json.decode(response.body);
      // return songJson.map((item) => SongDto.fromJson(item)).toList();
      List<Song> songs=[];
      for (var element in songJson.entries) {
        String id= element.key;
        Map<String,dynamic> value=element.value;
        songs.add(SongDto.fromJson(id, value));
        
        print(songs);
      }
      return songs;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
