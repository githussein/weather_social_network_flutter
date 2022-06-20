import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'predictions_screen.dart';
import '../providers/Auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;

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
                height: MediaQuery.of(context).size.height * 0.18,
                color: const Color(0xff814269),
                child: const Center(
                    child: Image(
                        image: AssetImage('assets/img/profile.png'),
                        height: 60)),
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
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              hintText: Provider.of<Auth>(context).username,
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
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              hintText: Provider.of<Auth>(context).userEmail,
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
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              hintText: Provider.of<Auth>(context).userCountry,
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
                          child: TextField(
                            // controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              hintText: Provider.of<Auth>(context).userPhone,
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
                    width: 180,
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
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          try {
                            await Provider.of<Auth>(context, listen: false)
                                .signOut();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green.shade500,
                                content: const Text('تم تسجيل الخروج بنجاح'),
                              ),
                            );

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PredictionsScreen()));
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.deepPurple,
                                content: const Text(
                                    'فشل تسجيل الخروج. تحقق من الاتصال بالانترنت.'),
                              ),
                            );
                          }
                          setState(() => _isLoading = false);
                        },
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const Text('تسجيل الخروج',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff814269)))),
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
