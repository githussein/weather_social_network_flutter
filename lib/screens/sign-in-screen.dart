import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل الدخول',
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
            const Text(
              'لديك حساب؟ قم بتسجيل الدخول',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'سنرسل لك رسالة تحتوي على رابط يمكنك من خلاله انشاء كلمة مرور جديده',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xff707070)),
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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
                  child: const Text('إرسال', style: TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
