class User {
  int id;
  String name;
  String email;
  String password;
  String country;
  String phone;
  String facebookToken;
  String googleToken;
  String token;
  String pic;
  String date;
  String coupon;
  int ban;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password = '',
    required this.country,
    this.phone = '',
    this.facebookToken = '',
    this.googleToken = '',
    required this.token,
    this.pic = '',
    required this.date,
    this.coupon = '',
    this.ban = 0,
  });
}
