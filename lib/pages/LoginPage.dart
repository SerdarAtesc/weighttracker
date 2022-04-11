// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weighttracker/pages/RegisterPage.dart';
import 'package:weighttracker/services/AuthController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  bool? loading = false;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/login.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 60.0,
                      ),
                      child: const Text(
                        'OMS\n LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginEmailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (input) => email = input,
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: loginPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (input) => password = input,
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  maximumSize: const Size(170.0, 90.0),
                                  minimumSize: const Size(170.0, 60.0),
                                  primary: Colors.black,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  AuthController.instance.login(
                                      loginEmailController.text,
                                      loginPasswordController.text);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text('LOG IN'),
                                    const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to((const RegisterPage()));
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
