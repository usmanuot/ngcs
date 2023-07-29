import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ngcs/Screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../CustomWidgets/custom_text_field.dart';
import '../View_Models/registeration_view_model.dart';

class MyRegisterationScreen extends StatefulWidget {
  const MyRegisterationScreen({Key? key}) : super(key: key);

  @override
  State<MyRegisterationScreen> createState() => _MyRegisterationScreen();
}

class _MyRegisterationScreen extends State<MyRegisterationScreen> {
  RegisterationScreeenViewModel registerationScreeenViewModel =
      RegisterationScreeenViewModel();
  // File? pickedImage;
  bool loading = false;
  var file;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterationScreeenViewModel>.reactive(
        viewModelBuilder: () => registerationScreeenViewModel,
        onViewModelReady: (model) {
          model.initialize(context);
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                  child: model.loader == false
                      ? Column(crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Form(
                                  key: model.formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 18),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 115,
                                          width: 115,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            fit: StackFit.expand,
                                            children: [
                                              ClipOval(
                                                child: model.fileName != null
                                                    ? Image.file(
                                                        model.fileName!,
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.center,
                                                        height: 75,
                                                        width: 75)
                                                    : Image.asset(
                                                        'assets/images/login.png',
                                                        fit: BoxFit.cover,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                      ),
                                              ),
                                              Positioned(
                                                  bottom: 0,
                                                  right: -25,
                                                  child: RawMaterialButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        model.pickImg(
                                                            ImageSource
                                                                .gallery);
                                                        model.update();
                                                      });
                                                    },
                                                    elevation: 2.0,
                                                    fillColor: Colors.white,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    shape: const CircleBorder(),
                                                    child: const Icon(
                                                      Icons
                                                          .add_a_photo_outlined,
                                                      size: 17,
                                                      color: Colors.blue,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        RoundedTextField(
                                            hintText:
                                                'Enter Company Tax Number',
                                            leading: const Icon(
                                                Icons.handyman_outlined,
                                                color: Colors.red),
                                            controller:
                                                model.taxNumberController,
                                            onempty: 'Tax Number Required',
                                            textInputType: TextInputType.text),

                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter Company Name',
                                            leading: const Icon(
                                                Icons.home_outlined,
                                                color: Colors.red),
                                            controller: model.comNameController,
                                            onempty: 'Company Name Required',
                                            textInputType: TextInputType.text),

                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter Company Number',
                                            leading: const Icon(
                                                Icons.call_outlined,
                                                color: Colors.red),
                                            controller:
                                                model.comNumberController,
                                            onempty: 'Company Number Required',
                                            textInputType:
                                                TextInputType.number),

                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter CEO Name',
                                            leading: const Icon(
                                                Icons.person_outline,
                                                color: Colors.red),
                                            controller: model.ceoNameController,
                                            onempty: 'CEO Name Required',
                                            textInputType: TextInputType.text),
                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter Manager Name',
                                            leading: const Icon(
                                                Icons.person_outline,
                                                color: Colors.red),
                                            controller:
                                                model.comManagerNameController,
                                            onempty: 'Manager Name Required',
                                            textInputType: TextInputType.text),

                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter Manager Number',
                                            leading: const Icon(
                                                Icons.call_outlined,
                                                color: Colors.red),
                                            controller:
                                                model.managerNumberController,
                                            onempty: 'Manager Number Required',
                                            textInputType:
                                                TextInputType.number),
                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText:
                                                'Enter Main Branch Address',
                                            leading: const Icon(
                                                Icons.add_business_sharp,
                                                color: Colors.red),
                                            controller:
                                                model.comAddressController,
                                            onempty:
                                                'Main Branch Address Required',
                                            textInputType: TextInputType.text),
                                        const SizedBox(height: 20),

                                        RoundedTextField(
                                            hintText: 'Enter Other Address',
                                            leading: const Icon(
                                                Icons.home_outlined,
                                                color: Colors.red),
                                            controller:
                                                model.otherAddressController,
                                            onempty: 'Other Branch Required',
                                            textInputType: TextInputType.text),

                                        const SizedBox(height: 20),

                                        // SizedBox(height: 20),
                                        RoundedTextField(
                                            hintText: 'Enter Email Address',
                                            leading: const Icon(
                                                Icons.email_outlined,
                                                color: Colors.red),
                                            controller: model.emailController,
                                            onempty: 'Email Required',
                                            textInputType:
                                                TextInputType.emailAddress),

                                        const SizedBox(height: 20),

                                        // TextFormField(
                                        //   controller: model.ceoNameController,
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       _showSuffixIcon = value.isNotEmpty;
                                        //     });
                                        //   },
                                        //   decoration: InputDecoration(
                                        //     border: OutlineInputBorder(),
                                        //     suffixIcon: _showSuffixIcon
                                        //         ? IconButton(
                                        //             icon: const Icon(Icons.clear),
                                        //             onPressed: () {
                                        //               // Clear the text field and hide the suffix icon
                                        //               model.ceoNameController.clear();
                                        //               setState(() {
                                        //                 _showSuffixIcon = false;
                                        //               });
                                        //             },
                                        //           )
                                        //         : null,
                                        //     hintText: 'Enter your text',
                                        //   ),
                                        // ),
                                        //
                                        // const SizedBox(height: 20),
                                        RoundedTextField(
                                            hintText: 'Enter Password',
                                            leading: const Icon(
                                                Icons.lock_outline,
                                                color: Colors.red),
                                            controller:
                                                model.passwordController,
                                            onempty: 'Password Required',
                                            textInputType:
                                                TextInputType.visiblePassword),

                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                            onPressed: () {
                                              model
                                                  .signUpUserAndSaveRealtimeData(
                                                      context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 10,
                                                    bottom: 10),
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                )),
                                            child: const Text(
                                              'Register',
                                              style: TextStyle(fontSize: 17),
                                            )
                                            // : const CircularProgressIndicator()),
                                            ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 100),
                                    child: const Text(
                                        "Already have an account?",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyLoginScreen()));
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ))
                                ],
                              ),
                            ])
                      : const Center(child: CircularProgressIndicator())));
        });
  }
}
