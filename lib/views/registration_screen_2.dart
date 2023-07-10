// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_user_controller.dart';
import 'login_screen.dart';
import '../main.dart';

RegisterUserController? registerUserController;

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  String _name = "";
  String _phone = "";
  String _selectedStream = "";
  String _selectedDistrict = "";

  String _email = "";
  String _newPassword = "";
  String _confirmPassword = "";

  @override
  void initState() {
    var dataFromPreviousScreen = Get.arguments;
    print("Data from previous: $dataFromPreviousScreen");

    setState(() {
      _name = dataFromPreviousScreen[0]["name"];
      _phone = dataFromPreviousScreen[1]["phone"];
      _selectedStream = dataFromPreviousScreen[2]["selectedStream"];
      _selectedDistrict = dataFromPreviousScreen[3]["selectedDistrict"];
    });
    registerUserController = Get.put(RegisterUserController());
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            'Email address',
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: emailValidator,
                        onSaved: (value) {
                          _email = value!;
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
                            'New password',
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController1,
                        validator: passwordValidator,
                        onSaved: (value) {
                          _newPassword = value!;
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
                            'Confirm password',
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController2,
                        validator: passwordValidator,
                        onSaved: (value) {
                          _confirmPassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          child: const Text('Register'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              print("Printing all the data...");
                              print("_name: $_name");
                              print("_phone: $_phone");
                              print("_selectedStream: $_selectedStream");
                              print("_selectedDistrict: $_selectedDistrict");
                              print("_email: $_email");
                              print("_newPassword: $_newPassword");
                              print("_confirmPassword: $_confirmPassword");

                              register();
                            }

                            registerUserController!.writeUserDataInFirebase(
                              userEmail: _email,
                              userPassword: _confirmPassword,
                              userName: _name,
                              userPhone: _phone,
                              userALStream: _selectedStream,
                              userDistrict: _selectedDistrict,
                            );
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }),
                              );
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
          )
        ],
      ),
    );
  }

  String? emailValidator(value) {
    if (value!.isEmpty) {
      return 'Email address cannot be empty';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  Future register() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController2.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
