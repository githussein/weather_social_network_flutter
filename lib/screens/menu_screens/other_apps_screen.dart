import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherAppsScreen extends StatelessWidget {
  const OtherAppsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    return SizedBox(
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
              'تطبيقات ومواقع مفيدة',
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
                InkWell(
                    onTap: () => _launchInBrowser(
                        Uri(scheme: 'https', host: 'www.gheym.com')),
                    child: const AppDrawerItem(
                        'موقع غيم', 'assets/icon/globe.png')),
                _buildDivider(),
                InkWell(
                    onTap: () => _launchInBrowser(Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.izzedineeita.ghym')),
                    child: const AppDrawerItem(
                        'تطبيق غيم', 'assets/icon/globe.png')),
                Container(height: 1, color: Colors.blueGrey.shade100),
              ],
            ),
          ),
        ],
      )),
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
