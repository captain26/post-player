class VideoData {

  VideoData({this.comment,this.url});

  final String url;
   final String comment;

  factory VideoData.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String url = data['url'];
    final String comment = data['comment'];
    return VideoData(
      url: url,
      comment: comment
    );
  }

}