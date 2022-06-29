class Notif {
  final int id;
  final String subject;
  final String content;
  final String date;
  final String country;
  final String appearanceFor;
  final String appearanceAs;
  final String redirect;
  final String schedule;
  final String media;

  Notif({
    required this.id,
    required this.subject,
    required this.content,
    required this.date,
    required this.country,
    required this.appearanceFor,
    required this.appearanceAs,
    required this.redirect,
    required this.schedule,
    required this.media,
  });
}
