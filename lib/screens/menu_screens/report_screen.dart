import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/engagement.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _content = '';
  final _emailController = TextEditingController(text: '');
  final _contentController = TextEditingController(text: '');
  bool _isLoading = false;

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
            'بلغ عن مشكلة',
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
                      InkWell(
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
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              final response = await http.post(
                                Uri.parse(
                                    'https://app.app-backend.com/api/send-ticket'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: json.encode({
                                  'email': _emailController.text,
                                  'content': _contentController.text
                                }),
                              );

                              if (response.statusCode == 200) {
                                _emailController.clear();
                                _contentController.clear();

                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green.shade500,
                                    content: const Text(
                                        'شكرا لتواصلك معنا. تم إرسال رسالتك بنجاح.'),
                                  ),
                                );
                                // Navigator.of(context).pop();
                              } else if (response.statusCode == 404) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text(
                                        'لم يتم إرسال الرسالة. برجاء تحقق من الاتصال بالانترنت.'),
                                  ),
                                );
                              }
                            } catch (error) {
                              print('problem sending a ticket.');
                              rethrow;
                            }
                            setState(() => _isLoading = false);
                          }
                          // if (formKey.currentState!.validate()) {
                          //   _email = _emailController.text;
                          //   _content = _contentController.text;
                          //   try {
                          //     var statusCode = await Provider.of<Engagement>(
                          //             context,
                          //             listen: false)
                          //         .sendTicket('_email', '_content');
                        },
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const Text(
                                'إرسال',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                    'بحالة تواجد مشكلة بالتطبيق فقم بالأبلاغ عنها لحلها'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        hintStyle: TextStyle(fontSize: 18),
                        hintText: 'البريد الالكتروني',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        )),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'برجاء إدخال البريد الالكتروني';
                        }
                        return null;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _contentController,
                    minLines: 6,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      hintText:
                          'أشرح لنا تفاصيل المشلكة من فضلك: \n* مكان حدوث المشلكة\n * ذكر فيما كانت المشكلة تتكرر أم لا\n * الخطوات التي مررت بها قبل حدوث المشكلة\n * إرفاق صورة تظهر المشكلة أن امكن\n *إرفاق فيديو يبين المشلكة أن أمكن',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 10) {
                          return 'يجب أن يكون طول الرسالة أكثر من 10 أحرف.';
                        }
                        return null;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
