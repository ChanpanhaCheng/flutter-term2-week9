import 'dart:convert';

import 'package:myapp/START%20CODE%20(10)%202/data/dtos/artists_dto.dart';
import 'package:myapp/START%20CODE%20(10)%202/data/repositories/artists/artist_repository.dart';
import 'package:myapp/START%20CODE%20(10)%202/model/artists/artist.dart';
import 'package:http/http.dart' as http;
class ArtistsRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.https('flutterpanha-default-rtdb.asia-southeast1.firebasedatabase.app');
  static final Uri artistsUri= baseUri.replace(path: '/artists.json');
  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);
    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of Artists
      Map<String,dynamic>  ArtistJson = json.decode(response.body);
      // return ArtistJson.map((item) => ArtistDto.fromJson(item)).toList();
      List<Artist> Artists=[];
      for (var element in ArtistJson.entries) {
        String id= element.key;
        Map<String,dynamic> value=element.value;
        Artists.add(ArtistsDto.fromJson(id, value));
        
        print(Artists);
      }
      return Artists;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }
    @override
  Future<Artist?> fetchArtistById(String id) async {}
}