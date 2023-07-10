// ignore_for_file: avoid_print

import 'package:firebase_email_pw_login/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();

  String _name = "";
  String _phone = "";
  String _selectedStream = "";
  String _selectedDistrict = "";

  List<String> streams = [
    'Arts',
    'Bio',
    'Commerce',
    'Maths',
    'Other',
    'Technology',
  ];
  String selectedStream = 'Technology';
  List<String> districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullativu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya'
  ];
  String selectedDistricts = 'Kandy';

  @override
  void dispose() {
    nameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Continue to registration',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Name',
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: nameValidator,
                        onSaved: (value) {
                          setState(() {
                            _name = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Mobile number',
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: mobileNumberController,
                        validator: phoneValidator,
                        onSaved: (value) {
                          setState(() {
                            _phone = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'A/L Stream',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedStream,
                                    items: streams
                                        .map((stream) =>
                                            DropdownMenuItem<String>(
                                              value: stream,
                                              child: Text(
                                                stream,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (stream) {
                                      _selectedStream = stream.toString();
                                      print(stream.toString());
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'District',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: size.width * 0.415,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedDistricts,
                                    items: districts
                                        .map((district) =>
                                            DropdownMenuItem<String>(
                                              value: district,
                                              child: Text(
                                                district,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (district) {
                                      _selectedDistrict = district.toString();
                                      print(district.toString());
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          child: const Text("Next"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              Get.toNamed(
                                Routes.getRegisterScreen2(),
                                arguments: [
                                  {"name": _name},
                                  {"phone": _phone},
                                  {"selectedStream": _selectedStream},
                                  {"selectedDistrict": _selectedDistrict},
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.getLogInScreen());
                            },
                            child: const Text(
                              ' Login.',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? nameValidator(value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? phoneValidator(value) {
    if (value!.isEmpty) {
      return 'Phone cannot be empty';
    }
    return null;
  }
}
