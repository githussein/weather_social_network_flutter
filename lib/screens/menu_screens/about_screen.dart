import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
            child: Column(
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'عن التطبيق',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              elevation: 0,
              centerTitle: false,
              backgroundColor: const Color(0xff426981),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(height: 1, color: Colors.blueGrey.shade100),
                  const AppDrawerItem(
                      'سياسة الخصوصية', 'assets/icon/globe.png'),
                  _buildDivider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            ImageIcon(
                              AssetImage('assets/icon/globe.png'),
                              size: 26,
                              color: Color(0xff707070),
                            ),
                            SizedBox(width: 10),
                            Text('رقم الإصدار',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff373A3C))),
                          ],
                        ),
                        const Text('1.0.1',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xff707070))),
                      ],
                    ),
                  ),
                  Container(height: 1, color: Colors.blueGrey.shade100),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

Widget _buildDivider() {
  // return Container(width: 200, height: 1.0, color: Colors.blueGrey.shade100);
  return Column(
    children: [
      Container(height: 1, color: Colors.blueGrey.shade100),
      const SizedBox(height: 8),
      Container(height: 1, color: Colors.blueGrey.shade100),
    ],
  );
}

class AppDrawerItem extends StatelessWidget {
  const AppDrawerItem(this.text, this.iconPath, {Key? key}) : super(key: key);

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage(iconPath),
                    size: 26,
                    color: const Color(0xff707070),
                  ),
                  const SizedBox(width: 10),
                  Text(text,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xff373A3C))),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff707070),
              ),
            ],
          ),
        ),
        // _buildDivider(),
      ],
    );
  }
}
