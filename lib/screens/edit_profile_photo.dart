import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                color: const Color(0xff814269),
                child: const Center(
                    child: Image(
                        image: AssetImage('assets/img/oman.png'), height: 60)),
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
                        const Expanded(
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              hintText: 'أحمد الشبلي',
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
                        const Expanded(
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              hintText: 'aaaaaa@gmail.com',
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
                        const Expanded(
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              hintText: 'سلطنة عمان',
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
                        const Expanded(
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              hintText: '99999999999',
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
                            // controller: _controller,
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
                                  const EdgeInsets.symmetric(horizontal: 26)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff814269)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                // side: BorderSide(color: Colors.red),
                              ))),
                          onPressed: () {},
                          child: const Text('حفظ',
                              style: TextStyle(fontSize: 22))),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(horizontal: 26)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff814269)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                // side: BorderSide(color: Colors.red),
                              ))),
                          onPressed: () {},
                          child: const Text('إلغاء',
                              style: TextStyle(fontSize: 22))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 26)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Color(0xff814269)),
                            ))),
                        onPressed: () {},
                        child: const Text('تسجيل الخروج',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xff814269)))),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
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
