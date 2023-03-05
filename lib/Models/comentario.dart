class Comment {
  String comment;
  var rating;
  String username;

  Comment(
      {required this.username, required this.comment, required this.rating});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        username: json['username'],
        comment: json['comment'],
        rating: json['rating']);
  }
}
