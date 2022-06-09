import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            const SizedBox(height: 0.5),
            Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xff426981),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'إلغاء',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'إرسال',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('بحالة تواجد مشكلة بالتطبيق فقم بالأبلاغ عنها لحلها'),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: TextStyle(fontSize: 18),
                  hintText: 'البريد الالكتروني',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 6,
                maxLines: 8,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: TextStyle(fontSize: 16),
                  hintText:
                      'أشرح لنا تفاصيل المشلكة من فضلك: \n* مكان حدوث المشلكة\n * ذكر فيما كانت المشكلة تتكرر أم لا\n * الخطوات التي مررت بها قبل حدوث المشكلة\n * إرفاق صورة تظهر المشكلة أن امكن\n *إرفاق فيديو يبين المشلكة أن أمكن',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
