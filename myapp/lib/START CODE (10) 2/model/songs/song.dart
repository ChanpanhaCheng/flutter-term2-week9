class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageUrl;

  Song({
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageUrl, required this.id,
  });

  @override
  String toString() {
    return 'Song( title: $title, artist: $artistId, duration: $duration)';
  }
}
