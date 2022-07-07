import 'package:flutter/material.dart';

class SendPhotoScreen extends StatefulWidget {
  const SendPhotoScreen({Key? key}) : super(key: key);

  @override
  State<SendPhotoScreen> createState() => _SendPhotoScreen();
}

class _SendPhotoScreen extends State<SendPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أرسل صورة أو مقطع'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30),
            onPressed: () => Navigator.of(context).pop(),
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
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'قم بإرسال إلينا صورة أو مقطع فيديو مرتبط بالطقس لإضافته بتطبيقنا',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'اسم المصور',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'موقع التصوير',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'التاريخ والوقت',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            // side: BorderSide(color: Colors.red),
                          ))),
                      onPressed: () {},
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            // side: BorderSide(color: Colors.red),
                          ))),
                      onPressed: () {},
                      child:
                          const Text('المعرض', style: TextStyle(fontSize: 22))),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 320,
                width: 180,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff707070))),
                child: const Center(
                  child: Text('معاينة'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
