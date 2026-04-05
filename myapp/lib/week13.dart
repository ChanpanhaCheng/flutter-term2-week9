import 'dart:async';

class DownloadService {
  final StreamController<int> _controller = StreamController();
   DownloadProgress downloadProgress= DownloadProgress(progress: 0, timestamp: 0);
  Stream<int> get stream => _controller.stream;

  void startDownload() async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 300));
      downloadProgress.progress+=1;
      downloadProgress.timestamp+=1;
      _controller.add(i);
      print(downloadProgress.progress);
      print(downloadProgress.timestamp);
    }
    _controller.close();
  }
}
class DownloadProgress {
   double progress;
   int timestamp;

  DownloadProgress({required this.progress, required this.timestamp});
}

void main(){

// 1 - Create a dedicated DownloadProgress class to carry the progress + the timestamp (datetime) 
Timer.periodic(Duration(seconds: 1), (timer){

});

// 2 - Change the stream to send DownloadProgress objects instead of just integers.

  // 3 - Update startDownload() to send the current time along with progress  (DateTime.now)

  // 4 - Listen to the stream.
  // 5 - For each new value, compute the estimated remaining time
  //    💡 Hint: Keep the first timestamp to calculate time difference.

  // 6 Print something like:  Progress: 30% | Remaining: 700ms
}