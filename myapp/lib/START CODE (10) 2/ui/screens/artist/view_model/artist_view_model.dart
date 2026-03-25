import 'package:flutter/material.dart';
import 'package:myapp/START%20CODE%20(10)%202/model/artists/artist.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
// import '../../../states/player_state.dart';
// import '../../../../model/Artists/Artist.dart';
import '../../../utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;


  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
   

    // init
    _init();
  }

  @override
  void dispose() {
  
    super.dispose();
  }

  void _init() async {
    fetchArtist();
  }

  void fetchArtist() async {
    // 1- Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

}
