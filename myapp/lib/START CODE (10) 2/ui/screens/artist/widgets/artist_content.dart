import 'package:flutter/material.dart';
import 'package:myapp/START%20CODE%20(10)%202/model/artists/artist.dart';
import 'package:myapp/START%20CODE%20(10)%202/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:provider/provider.dart';
// import '../../../../model/Artists/Artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
// import '../../../widgets/Artist/Artist_tile.dart';
// import '../view_model/Artist_view_model.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal Artist repository
    ArtistViewModel mv = context.watch<ArtistViewModel>();

    AsyncValue<List<Artist>> asyncValue = mv.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red),));

      case AsyncValueState.success:
        List<Artist> Artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: Artists.length,
          itemBuilder: (context, index) => artistTile(
            Artists[index]
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artist", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }

   Widget artistTile(Artist artist) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          leading: CircleAvatar(foregroundImage: NetworkImage(artist.imageUrl.toString())),
          title: Text(artist.name),
        ),
      ),
    );
  }
}
