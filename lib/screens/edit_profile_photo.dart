import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'bottom_nav_bar.dart';
import 'predictions_screen.dart';
import '../providers/Auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  File? image;
  bool _isLoading = false;
  bool _isEditing = false;
  var nameController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var countryController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  Dio dio = Dio();
  String? userToken;
  String? name;
  String? email;
  String? country;
  String? phone;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    userToken = Provider.of<Auth>(context, listen: false).userToken;
    name = Provider.of<Auth>(context, listen: false).username;
    email = Provider.of<Auth>(context, listen: false).userEmail;
    country = Provider.of<Auth>(context, listen: false).userCountry;
    phone = Provider.of<Auth>(context, listen: false).userPhone;

    nameController.text = name!;
    emailController.text = email!;
    countryController.text = country!;
    phoneController.text = phone!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('userToken: ${Provider.of<Auth>(context, listen: false).userToken}');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0,
          centerTitle: false,
          backgroundColor: const Color(0xff426981),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    color: const Color(0xff814269),
                    child: GestureDetector(
                      onTap: () async {
                        pickImage();
                      },
                      child: Center(
                          child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        child: image != null
                            ? ClipOval(
                                child: Image.file(
                                  image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipOval(
                                child: Provider.of<Auth>(context).userPic == ''
                                    ? const Image(
                                        image: AssetImage(
                                            'assets/img/profile.png'),
                                        height: 60)
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            Provider.of<Auth>(context).userPic),
                              ),
                      )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.person, color: Colors.grey),
                            const SizedBox(width: 8),
                            Container(width: 1, color: const Color(0xFF707070)),
                            Expanded(
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  hintText:
                                      Provider.of<Auth>(context, listen: false)
                                          .username,
                                  border: InputBorder.none,
                                ),
                                // onChanged: searchOrder,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.mail_outline, color: Colors.grey),
                            const SizedBox(width: 8),
                            Container(width: 1, color: const Color(0xFF707070)),
                            Expanded(
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  hintText: emailController.text,
                                  border: InputBorder.none,
                                ),
                                // onChanged: searchOrder,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.location_pin, color: Colors.grey),
                            const SizedBox(width: 8),
                            Container(width: 1, color: const Color(0xFF707070)),
                            Expanded(
                              child: TextFormField(
                                controller: countryController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  hintText: countryController.text,
                                  border: InputBorder.none,
                                ),
                                // onChanged: searchOrder,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.call, color: Colors.grey),
                            const SizedBox(width: 8),
                            Container(width: 1, color: const Color(0xFF707070)),
                            Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  hintText: phoneController.text,
                                  border: InputBorder.none,
                                ),
                                // onChanged: searchOrder,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.lock, color: Colors.grey),
                            const SizedBox(width: 8),
                            Container(width: 1, color: const Color(0xFF707070)),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  hintText: '***********',
                                  border: InputBorder.none,
                                ),
                                // onChanged: searchOrder,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 26)),
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff814269)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    // side: BorderSide(color: Colors.red),
                                  ))),
                              onPressed: () async {
                                setState(() => _isEditing = true);
                                Map<String, String> headers = <String, String>{
                                  // 'Content-Type': 'multipart/form-data',
                                  'Authorization': userToken!,
                                };
                                var picture;
                                if (image != null) {
                                  String fileName = image!.path.split('/').last;
                                  picture = await http.MultipartFile.fromPath(
                                      fileName, image!.path);
                                }
                                Map<String, String> requestBody =
                                    <String, String>{
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'country': countryController.text,
                                  'phone': phoneController.text,
                                };
                                try {
                                  var uri = Uri.parse(
                                      'https://app.app-backend.com/api/update-profile');
                                  var response = http.post(
                                    uri,
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                      'Authorization': userToken!,
                                    },
                                    body: json.encode({
                                      'name': nameController.text,
                                      'email': emailController.text,
                                      'country': countryController.text,
                                      'phone': phoneController.text,
                                    }),
                                  );
                                } catch (e) {
                                  rethrow;
                                }
                                setState(() => _isEditing = false);
                              },
                              child: _isEditing
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text('حفظ',
                                      style: TextStyle(fontSize: 22))),
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 26)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff814269)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    // side: BorderSide(color: Colors.red),
                                  ))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('إلغاء',
                                  style: TextStyle(fontSize: 22))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(horizontal: 26)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                      color: Color(0xff814269)),
                                ))),
                            onPressed: () async {
                              setState(() => _isLoading = true);
                              try {
                                await Provider.of<Auth>(context, listen: false)
                                    .signOut();

                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green.shade500,
                                    content:
                                        const Text('تم تسجيل الخروج بنجاح'),
                                  ),
                                );

                                // Navigator.of(context, rootNavigator: true)
                                //     .pushNamedAndRemoveUntil(
                                //         '/', (Route<dynamic> route) => false);
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                // Navigator.of(context)
                                //     .pushNamed(BottomNavBar.routeName);
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text(
                                        'فشل تسجيل الخروج. تحقق من الاتصال بالانترنت.'),
                                  ),
                                );
                              }
                              setState(() => _isLoading = false);
                            },
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Text('تسجيل الخروج',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff814269)))),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
