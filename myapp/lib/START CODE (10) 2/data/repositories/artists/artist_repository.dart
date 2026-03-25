import 'package:myapp/START%20CODE%20(10)%202/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
  Future<Artist?> fetchArtistById(String id);
}