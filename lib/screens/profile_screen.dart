import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';
import 'edit_profile_photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Auth>(context).getUserToken().then((_) {
        setState(() => _isLoading = false);
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                        padding: const EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen())),
                            child: const ImageIcon(
                              AssetImage('assets/icon/user.png'),
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Image(
                          image: AssetImage('assets/img/profile.png'),
                          height: 60),
                      const SizedBox(width: 10),
                      Text(Provider.of<Auth>(context).username,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        label: Text(Provider.of<Auth>(context).userCountry,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
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
                    child:
                        Text('عدد المشاركات: 3', textAlign: TextAlign.center)),
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
