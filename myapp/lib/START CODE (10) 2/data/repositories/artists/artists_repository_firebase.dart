import 'package:myapp/START%20CODE%20(10)%202/data/repositories/artists/artist_repository.dart';

class ArtistsRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.https('flutterpanha-default-rtdb.asia-southeast1.firebasedatabase.app');
  static final Uri songsUri= baseUri.replace(path: '/songs.json');

  
}