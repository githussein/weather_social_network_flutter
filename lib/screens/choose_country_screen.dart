import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class ChooseCountryScreen extends StatelessWidget {
  const ChooseCountryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('الرجاء اختيار الدولة'),
              elevation: 0,
              centerTitle: true,
              backgroundColor: const Color(0xff426981),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/img/oman.png'), height: 50),
                    Text('عمان'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 150,
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar())),
                  child: const Text('ابدأ', style: TextStyle(fontSize: 22))),
            ),
          ],
        ),
      ),
    );
  }
}
