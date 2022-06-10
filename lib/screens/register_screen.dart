import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'الاسم',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'البريد الالكتروني',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'كلمة المرور',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'إعادة كلمة المرور',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'الدولة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    )),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        // side: BorderSide(color: Colors.red),
                      ))),
                  onPressed: () {},
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        // side: BorderSide(color: Colors.red),
                      ))),
                  onPressed: () {},
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xff167EE6)),
                      ))),
                  onPressed: () {},
                  label: const Text('تسجيل بواسطة قوقل',
                      style:
                          TextStyle(fontSize: 16, color: Color(0xff167EE6)))),
            ),
            const SizedBox(height: 16),
            const Text(
              'لديك حساب؟ قم بتسجيل الدخول',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff814269)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
