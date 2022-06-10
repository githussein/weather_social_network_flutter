import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'المشاركات',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: const Color(0xff426981),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              color: const Color(0xff814269),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ImageIcon(
                          AssetImage('assets/icon/user.png'),
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image(image: AssetImage('assets/img/oman.png'), height: 60),
                    SizedBox(width: 10),
                    Text('أحمد الشبلي',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    SizedBox(width: 10),
                    TextButton.icon(
                      label: const Text('سلطنة عمان',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white)),
                      onPressed: () {},
                      icon: Image.asset('assets/icon/location.png',
                          width: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                  child: Text('عدد المشاركات: 3', textAlign: TextAlign.center)),
            ),
            Container(height: 0.3, color: Colors.grey),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: const <Widget>[
                  ListTile(
                    title: Text(
                      'سيكون طقس الاثنين صحوًا بوجه عام على معظم المحافظات مع احتمال تشكل سحب على جبال الحجر خلال المساء',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    subtitle: Text('منذ 1 دقيقة'),
                    trailing: Image(
                        fit: BoxFit.fill,
                        height: 90,
                        image: AssetImage('assets/img/camera.png')),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'حاليا أجواء ضبابية تغطي المنطقة مع توقعات بزيادتها خلال الساعات القادمة',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    subtitle: Text('منذ 1 يوم'),
                    trailing: Image(
                        fit: BoxFit.fill,
                        height: 90,
                        image: AssetImage('assets/img/weather.png')),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'توقعات الاخيره تشير لامطار غزيرة على دول الخليج خلال الأسبوع القادم',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    subtitle: Text('26/03/2022- 4:29'),
                    trailing: Image(
                        fit: BoxFit.fill,
                        height: 90,
                        image: AssetImage('assets/img/sat.png')),
                  ),
                  Divider(),
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
