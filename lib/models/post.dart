class Post {
  final int id;
  final String title;
  final String date;
  final String country;
  final String details;
  final int likes;
  final int shares;
  final List<dynamic> files;

  Post({
    required this.id,
    this.title = '',
    required this.date,
    this.country = '',
    required this.details,
    this.likes = 0,
    this.shares = 0,
    required this.files,
  });
}
