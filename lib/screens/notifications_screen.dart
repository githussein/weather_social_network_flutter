import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';
import '../widgets/notifs_listview.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Data>(context, listen: false)
          .getNotifications()
          .then((_) => setState(() => _isLoading = false));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
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
              'التنبيهات',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            elevation: 0,
            centerTitle: false,
            backgroundColor: const Color(0xff426981),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تحرير',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Column(
                  children: const [
                    NotifsListView(),
                    Divider(),
                  ],
                )
                  // ListView(
                  //   children: const <Widget>[
                  //     ListTile(
                  //       title: Text('آخر تحديث للنموذج الأوروبي لتوقعات الامطار',
                  //           maxLines: 1),
                  //       subtitle: Text('2022.04.24 - 8:00AM'),
                  //       trailing: Image(
                  //           fit: BoxFit.fill,
                  //           height: 42,
                  //           image: AssetImage('assets/img/weather.png')),
                  //     ),
                  //     Divider(),
                  //     ListTile(
                  //       title: Text('آخر تحديث للنموذج الأمريكي لتوقعات الامطار',
                  //           maxLines: 1),
                  //       subtitle: Text('2022.04.24 - 8:00AM'),
                  //       trailing: Image(
                  //           fit: BoxFit.fill,
                  //           height: 42,
                  //           image: AssetImage('assets/img/sat.png')),
                  //     ),
                  //     Divider(),
                  //     ListTile(
                  //       title: Text('توقعات بالحالة الجوية نهاية مايو', maxLines: 1),
                  //       subtitle: Text('2022.04.24 - 8:00AM'),
                  //       trailing: Image(
                  //           fit: BoxFit.fill,
                  //           height: 42,
                  //           image: AssetImage('assets/img/camera.png')),
                  //     ),
                  //     Divider(),
                  //     ListTile(
                  //       title: Text('بداية تأثر السلطنة بالحالة الجوية', maxLines: 1),
                  //       subtitle: Text('2022.04.24 - 8:00AM'),
                  //       trailing: Image(
                  //           fit: BoxFit.fill,
                  //           height: 42,
                  //           image: AssetImage('assets/img/oman.png')),
                  //     ),
                  //     Divider(),
                  //     ListTile(
                  //       title: Text('تم إضافة رد على تعليقك', maxLines: 1),
                  //       subtitle: Text('2022.04.24 - 8:00AM'),
                  //       trailing: Image(
                  //           fit: BoxFit.fill,
                  //           height: 42,
                  //           image: AssetImage('assets/img/weather.png')),
                  //     ),
                  //     Divider(),
                  //   ],
                  // ),
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
