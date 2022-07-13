import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/Auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class SendPhotoScreen extends StatefulWidget {
  const SendPhotoScreen({Key? key}) : super(key: key);

  @override
  State<SendPhotoScreen> createState() => _SendPhotoScreen();
}

class _SendPhotoScreen extends State<SendPhotoScreen> {
  final formKey = GlobalKey<FormState>();
  File? image;
  bool _isLoading = false;
  bool _isSending = false;
  var nameController = TextEditingController(text: '');
  var locationController = TextEditingController(text: '');
  var dateController = TextEditingController(text: '');
  String? userToken;
  late int id;
  late String name;
  late String location;
  late String date;
  Dio dio = Dio();

  @override
  void initState() {
    userToken = Provider.of<Auth>(context, listen: false).userToken;
    id = Provider.of<Auth>(context, listen: false).userId;
    name = Provider.of<Auth>(context, listen: false).username;
    location = Provider.of<Auth>(context, listen: false).userEmail;
    date = Provider.of<Auth>(context, listen: false).userCountry;

    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'user_id': id,
      'photographer': nameController.text,
      'location': locationController.text,
      'date': dateController.text,
      'media': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    var response = await dio
        .post("https://admin.rain-app.com/api/send-pending-shot",
            data: formData,
            options: Options(headers: <String, String>{
              'Authorization': userToken!,
            }))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green.shade500,
            content: const Text('تم الإرسال بنجاح. شكرا لمشاركتك.')));
      }
    });
    print('newMethodResponse: ${response.statusCode}');
    return response.data['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أرسل صورة أو مقطع'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
                const SizedBox(height: 0.5),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: const Color(0xff426981),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(width: 0.5, color: const Color(0xFFFEF9F9)),
                      GestureDetector(
                        onTap: () async {
                          setState(() => _isSending = true);

                          Map<String, String> headers = <String, String>{
                            'Content-type': 'multipart/form-data',
                            'Authorization': "Bearer ${userToken!}",
                          };
                          var picture;
                          String fileName = 'img';
                          if (image != null) {
                            fileName = image!.path.split('/').last;
                            picture = await http.MultipartFile.fromPath(
                                fileName, image!.path);
                          }

                          try {
                            // var formData = FormData.fromMap({
                            //   'user_id': 1,
                            //   'photographer': nameController.text,
                            //   'location': locationController.text,
                            //   'date': dateController.text,
                            //   'media': await MultipartFile.fromFile(image!.path,
                            //       filename: fileName)
                            // });
                            // await dio
                            //     .post(
                            //         'https://admin.rain-app.com/api/send-pending-shot',
                            //         data: formData,
                            //         options: Options(
                            //           headers: headers,
                            //           followRedirects: false,
                            //           validateStatus: (status) => true,
                            //         ))
                            //     .then((response) {
                            //   if (response.statusCode == 500) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         backgroundColor: Colors.purple.shade700,
                            //         content:
                            //             const Text('Internal server error'),
                            //       ),
                            //     );
                            //   } else if (response.statusCode == 200) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         backgroundColor: Colors.green.shade500,
                            //         content: const Text(
                            //             'تم الإرسال بنجاح. شكرا لمشاركتك.'),
                            //       ),
                            //     );
                            //   }
                            // });

                            await uploadImage(image!);
                            // var request = http.MultipartRequest('POST', uri);
                            // request.headers.addAll(
                            //     headers); //if u have headers, basic auth, token bearer... Else remove line
                            // request.fields['photographer'] = 'SAMY';
                            // request.files.add(await http.MultipartFile.fromPath(
                            //   'img',
                            //   image!.path,
                            //   contentType: MediaType('image', 'jpeg'),
                            // ));
                            // // ..files.add(picture);
                            // request.send().then((response) =>
                            //     print('sendStatus: ${response.statusCode}'));
                          } catch (e) {
                            print('sendStatus: $e');
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.purple.shade700,
                              content: const Text('Internal server error'),
                            ));
                          }
                          setState(() => _isSending = false);
                        },
                        child: _isSending
                            ? const Center(child: CircularProgressIndicator())
                            : const Text(
                                'إرسال',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'قم بإرسال إلينا صورة أو مقطع فيديو مرتبط بالطقس لإضافته بتطبيقنا',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'اسم المصور',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
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
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'موقع التصوير',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || value.length < 2) {
                          return 'برجاء إدخال الموقع';
                        }
                        return null;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'التاريخ والوقت',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || value.length < 2) {
                          return 'برجاء إدخال التاريخ والوقت';
                        }
                        return null;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Text('يفضل أن يكون حجم الصورة او مقطع الفيديو 9:16'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 26)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff814269)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // side: BorderSide(color: Colors.red),
                            ))),
                        onPressed: () async => pickImage(ImageSource.camera),
                        child: const Text('الكاميرا',
                            style: TextStyle(fontSize: 22))),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 26)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff814269)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // side: BorderSide(color: Colors.red),
                            ))),
                        onPressed: () async => pickImage(ImageSource.gallery),
                        child: const Text('المعرض',
                            style: TextStyle(fontSize: 22))),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 320,
                  width: 180,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff707070))),
                  child: Center(
                    child: image == null
                        ? const Text('معاينة')
                        : Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
