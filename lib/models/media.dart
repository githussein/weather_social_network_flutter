class Media {
  final int id;
  final String photographer;
  final String location;
  final String date;
  final String schedule;
  final String hide;
  final int shares;
  final String media;

  Media({
    required this.id,
    required this.photographer,
    required this.location,
    required this.date,
    this.schedule = '',
    this.hide = '',
    required this.shares,
    required this.media,
  });
}
