import 'package:flutter/material.dart';
import 'package:matar_weather/screens/profile_screen.dart';
import 'sign-in-screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _country = '';
  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController1 = TextEditingController(text: '');
  final _passwordController2 = TextEditingController(text: '');
  final _countryController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: const Color(0xff426981),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'الاسم',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      )),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty || value.length < 2) {
                        return 'برجاء إدخال الاسم';
                      }
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'البريد الالكتروني',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      )),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty ||
                          !value.contains('@') ||
                          !value.contains('.')) {
                        return 'برجاء إدخال البريد الالكتروني';
                      }
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _passwordController1,
                  obscureText: true,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'كلمة المرور',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      )),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty || value.length < 6) {
                        return 'كلمة المرور غير صحيحة';
                      }
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _passwordController2,
                  obscureText: true,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'إعادة كلمة المرور',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      )),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty || value.length < 6) {
                        return 'كلمة المرور غير صحيحة';
                      } else if (_passwordController2.text !=
                          _passwordController1.text) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'الدولة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      )),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty || value.length < 3) {
                        return 'برجاء إدخال الدولة';
                      }
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 280,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 26)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff814269)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          // side: BorderSide(color: Colors.red),
                        ))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _name = _nameController.text;
                        _email = _emailController.text;
                        _password = _passwordController2.text;
                        _country = _countryController.text;
                        print('\n\n\nUUUUUUUUUUUUUUUUUUsername: $_name');
                        print('\n\n\nUUUUUUUUUUUUUUUUUUsername: $_email');
                        print('\n\n\nUUUUUUUUUUUUUUUUUUsername: $_password');
                        print('\n\n\nUUUUUUUUUUUUUUUUUUsername: $_country');
                      }
                    },
                    child: const Text('تسجيل', style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  const Text('أو', style: TextStyle(color: Colors.black)),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextButton.icon(
                    icon: const ImageIcon(
                      AssetImage('assets/icon/facebook.png'),
                      size: 26,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 26)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff1976D2)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side: BorderSide(color: Colors.red),
                        ))),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen())),
                    label: const Text('تسجيل بواسطة الفيسبوك',
                        style: TextStyle(fontSize: 16))),
              ),
              SizedBox(
                width: 300,
                child: TextButton.icon(
                    icon: const ImageIcon(
                      AssetImage('assets/icon/twitter.png'),
                      size: 26,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 26)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff00ACEE)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side: BorderSide(color: Colors.red),
                        ))),
                    onPressed: () {},
                    label: const Text('تسجيل بواسطة تويتر',
                        style: TextStyle(fontSize: 16))),
              ),
              SizedBox(
                width: 300,
                child: TextButton.icon(
                    icon: const Image(
                      image: AssetImage('assets/icon/google.png'),
                      height: 26,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 26)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xff167EE6)),
                        ))),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen())),
                    label: const Text('تسجيل بواسطة قوقل',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff167EE6)))),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen())),
                child: const Text(
                  'لديك حساب؟ قم بتسجيل الدخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff814269)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
