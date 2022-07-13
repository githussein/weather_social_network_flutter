import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// The authentication provider
class Auth with ChangeNotifier {
  /// The locally stored data
  bool isSignedIn = false;
  int userId = -1;
  String username = '';
  String userEmail = '';
  String userPhone = '';
  String userCountry = '';
  String userPic = '';
  String userToken = '';
  String googleToken = '';
  String facebookToken = '';
  var authHeader = {'Authorization': ''};
  // late User currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> saveUserData(Map<String, dynamic> user) async {
    // currentUser = User(
    //   id: user['id'] ?? -1,
    //   name: user['name'] ?? '',
    //   email: user['email'] ?? '',
    //   phone: user['phone'] ?? '',
    //   country: user['country'] ?? '',
    //   pic: user['pic'] ?? '',
    //   token: user['token'] ?? '',
    //   date: user['date'] ?? '',
    // );

    // currentUser.id = user['id'] ?? -1;
    // currentUser.name = user['name'] ?? '';
    // currentUser.email = user['email'] ?? '';
    // currentUser.password = user['password'] ?? '';
    // currentUser.country = user['country'] ?? '';
    // currentUser.phone = user['phone'] ?? '';
    // currentUser.facebookToken = user['facebook_token'] ?? '';
    // currentUser.googleToken = user['google_token'] ?? '';

    // print(
    //     'UserInfo: \n${currentUser.id}\n${currentUser.name}\n${currentUser.email}\n${currentUser.password}\n${currentUser.country}\n${currentUser.token}\n${currentUser.date}\n${currentUser.phone}\n');
    userId = user['id'] ?? -1;
    username = user['name'] ?? '';
    userEmail = user['email'] ?? '';
    userPhone = user['phone'] ?? '';
    userCountry = user['country'] ?? '';
    userPic = user['pic'] ?? '';
    userToken = user['token'] ?? '';
    authHeader = {'Authorization': user['token'] ?? ''};

    //Save in device storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userId);
    await prefs.setString('name', username);
    await prefs.setString('email', userEmail);
    await prefs.setString('phone', userPhone);
    await prefs.setString('country', userCountry);
    await prefs.setString('pic', userPic);
    await prefs.setString('token', userToken);
    print('locallySaved: $username, $userPhone, $userToken}');
  }

  Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('id') ?? -1;
    username = prefs.getString('name') ?? '...';
    userEmail = prefs.getString('email') ?? '';
    userPhone = prefs.getString('phone') ?? '';
    userCountry = prefs.getString('country') ?? '';
    userPic = prefs.getString('pic') ?? '';
    userToken = prefs.getString('token') ?? '';
    print('inGetUser: $username, $userCountry, $userPhone, $userToken}');
    isSignedIn = userToken.isNotEmpty;
    return prefs.getString('token') ?? '';
  }

  /// Signs a user in using basic authentication.
  ///
  /// Takes the [baseUrl] as the target url. Takes [username] and [password]
  /// to generate a header for basic authentication.
  Future<int> register(String name, String email, String password, country,
      {String phone = ''}) async {
    try {
      final response = await http.post(
        Uri.parse('https://admin.rain-app.com/api/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'country': country
        }),
      );

      notifyListeners();
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://admin.rain-app.com/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'email': email, 'password': password}),
      );

      saveUserData(jsonDecode(response.body));
      isSignedIn = true;

      notifyListeners();
      return response.statusCode;
    } catch (error) {
      print('problem signing in');
      rethrow;
    }
  }

  Future<int> signInWithGoogle() async {
    int statusCode = 0;
    try {
      _googleSignIn.signIn().then((userData) {
        username = userData!.displayName ?? '';
        userEmail = userData.email ?? '';
        googleToken = userData.id ?? '';
        userPic = userData.displayName ?? '';
      }).then((_) async {
        final response = await http.post(
          Uri.parse('https://admin.rain-app.com/api/auth/social/google'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': username,
            'email': userEmail,
            'google_token': googleToken,
          }),
        );

        saveUserData(jsonDecode(response.body));
        isSignedIn = true;

        statusCode = 200;
        notifyListeners();
      });
      return statusCode;
    } catch (error) {
      print('problem signing in with Google.');
      return 400;
    }
  }

  Future<int> signInWithFacebook() async {
    int statusCode = 0;
    try {
      // final LoginResult result = await FacebookAuth.instance.login(
      //     permissions: [
      //       "email",
      //       "public_profile",
      //       "user_friends"
      //     ]); // by default we request the email and the public profile
// or FacebookAuth.i.login()
//       if (result.status == LoginStatus.success) {
//         // you are logged
//         final AccessToken accessToken = result.accessToken!;
//         print('Facebook: $AccessToken');
//       } else {
//         print('Facebook: ${result.status}');
//         print(result.message);
//       }
      // FacebookAuth.instance
      //     .login(permissions: ['public_profile', 'email'])
      //     .then((value) => FacebookAuth.instance.getUserData())
      //     .then((userData) {
      //       print('userFacebook: $userData}');
      //       username = userData['name'];
      //       userEmail = userData['email'];
      //       facebookToken = 'facebook_token';
      //     })
      //     .then((_) async {
      //       final response = await http.post(
      //         Uri.parse('https://admin.rain-app.com/api/auth/social/google'),
      //         headers: <String, String>{
      //           'Content-Type': 'application/json; charset=UTF-8',
      //         },
      //         body: json.encode({
      //           'name': username,
      //           'email': userEmail,
      //           'google_token': googleToken,
      //         }),
      //       );
      //
      //       saveUserData(jsonDecode(response.body));
      //       isSignedIn = true;
      //
      //       statusCode = 200;
      //       notifyListeners();
      //     });
      return statusCode;
    } catch (error) {
      print('problem signing in with Facebook.');
      return 400;
    }
  }

  Future<void> signOut() async {
    isSignedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('country');
    await prefs.remove('pic');
    await prefs.remove('token');
  }
}
