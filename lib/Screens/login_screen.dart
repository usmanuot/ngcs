import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/registeration_screen.dart';
import 'package:new_ngcs/View_Models/login_screen_view_model.dart';
import 'package:stacked/stacked.dart';

import '../CustomWidgets/custom_text_field.dart';

class MyLoginScreen extends StatefulWidget {
  String? email, password;
  MyLoginScreen({this.email, this.password});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  LoginViewModel loginViewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => loginViewModel,
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  body: SingleChildScrollView(
                      child: model.loader == false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const Image(
                                    image:
                                        AssetImage('assets/images/login.png'),
                                    width: 100,
                                    height: 150,
                                  ),
                                  Form(
                                      key: model.formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, right: 18),
                                        child: Column(
                                          children: [
                                            // SizedBox(height: 20),
                                            RoundedTextField(
                                                hintText: 'Enter Email Address',
                                                leading: const Icon(Icons.email,
                                                    color: Colors.red),
                                                controller:
                                                    model.emailController,
                                                onempty: 'Email Required',
                                                textInputType:
                                                    TextInputType.emailAddress),

                                            const SizedBox(height: 20),
                                            RoundedTextField(
                                                hintText: 'Enter Password',
                                                leading: const Icon(
                                                    Icons.lock_outline,
                                                    color: Colors.red),
                                                controller:
                                                    model.passwordController,
                                                onempty: 'Password Required',
                                                textInputType:
                                                    TextInputType.text,
                                                obscure: true),

                                            const SizedBox(height: 10),
                                            Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                // margin: EdgeInsets.only(left: 210),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(),
                                                  child: const Text(
                                                      'FORGOT PASSWORD?',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      )),
                                                )),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  // print('i m pressed');
                                                  if (model
                                                      .formKey.currentState!
                                                      .validate()) {
                                                    model
                                                        .signInWithEmailAndPassword(
                                                            context);
                                                    model.Dispose();
                                                  }
                                                  // if (loginViewModel.validateForm()) {

                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             MyRegisterationScreen()));

                                                  // }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30,
                                                            top: 10,
                                                            bottom: 10),
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    )),
                                                child: const Text(
                                                  'Login',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                )),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      )),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(left: 100),
                                        child: Text("Don't have an account?",
                                            style:
                                                TextStyle(color: Colors.green)),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyRegisterationScreen()));
                                          },
                                          child: const Text(
                                            'SignUp',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ))
                                    ],
                                  ),
                                ])
                          : const Center(child: CircularProgressIndicator()))));
        });
  }
}
