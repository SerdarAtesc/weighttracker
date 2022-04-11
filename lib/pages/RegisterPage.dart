// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weighttracker/pages/LoginPage.dart';
import 'package:weighttracker/services/AuthController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKeyRegister = GlobalKey<FormState>();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();

  TextEditingController signupNameController = TextEditingController();

  TextEditingController signupPasswordController = TextEditingController();
  bool? loading = false;
  TextEditingController signupEmailController = TextEditingController();
  String? userName;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyRegister,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/login.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
                elevation: null,
                backgroundColor: Colors.transparent,
                leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                )),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'REGISTER\n NOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.28,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            fillColor: Colors.transparent,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                          onSaved: (input) => userName = input,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onSaved: (input) => email = input,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          obscureText: true,
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onSaved: (input) => password = input,
                        ),
                        SizedBox(height: 30.0),
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
                                  AuthController.instance.register(
                                      signupEmailController.text,
                                      signupPasswordController.text);
                                  //_register();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('REGISTER'),
                                    Icon(
                                      Icons.content_paste_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => LoginPage());
                              },
                              child: Text(
                                'Login',
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
