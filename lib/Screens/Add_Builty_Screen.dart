import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/Dashboard_Screen.dart';
import 'package:new_ngcs/View_Models/login_screen_view_model.dart';
import 'package:new_ngcs/View_Models/splash_view_model.dart';
import 'package:stacked/stacked.dart';

import '../CustomWidgets/add_builty_text_field.dart';
import '../CustomWidgets/custom_text_field.dart';
import '../View_Models/Add_Builty_View_Model.dart';
import 'login_screen.dart';

class AddBuiltyScreen extends StatefulWidget {
  const AddBuiltyScreen({Key? key}) : super(key: key);

  @override
  State<AddBuiltyScreen> createState() => _AddBuiltyScreen();
}

class _AddBuiltyScreen extends State<AddBuiltyScreen> {
  AddBuiltyViewModel addBuiltyViewModel = AddBuiltyViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBuiltyViewModel>.reactive(
        viewModelBuilder: () => addBuiltyViewModel,
        onViewModelReady: (model) {
          model.initialize(context);
        },
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.green[200],
                  appBar: AppBar(
                    title: const Text('Add Builty'),
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: Form(
                          key: model.formKey,
                          child: Column(children: [
                            BuiltTextField(
                                controller1: model.receiverController,
                                title1: 'Receiver:- ',
                                hintText1: 'Enter reciever..',
                                title2: ' -:Sender',
                                hintText2: 'Enter Sender..',
                                controller2: model.senderController),
                            BuiltTextField(
                                controller1: model.fromCityController,
                                title1: 'From City:- ',
                                hintText1: 'Enter from city name..',
                                title2: ' -:To City',
                                hintText2: 'Enter to city name..',
                                controller2: model.toCityController),
                            BuiltTextField(
                                controller1: model.driverNameController,
                                title1: 'Driver:- ',
                                hintText1: 'Enter driver name..',
                                title2: ' -:Truck Number',
                                hintText2: 'Enter truck number..',
                                controller2: model.truckNumberController),
                            Container(
                              padding: const EdgeInsets.only(top: 3, bottom: 1),
                              height: 60,
                              child: Card(
                                borderOnForeground: true,
                                color: Colors.white,
                                elevation: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 5),
                                    const Text('Date:- ',
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(
                                      // height: 22,
                                      // width: 80,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              child: Text(
                                            model.currentDate +
                                                model.currentTime,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  size: 15,
                                                  Icons.date_range_outlined)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      height: 20,
                                      child: Text(model.counter.toString()),
                                    ),
                                    const Text('   -: Builty Number',
                                        style: TextStyle(fontSize: 12)),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('**********----------**********',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Numbering:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        textInputType: TextInputType.number,
                                        hintText: 'Numbering..',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller: model.numberingController),
                                  )),
                                  const SizedBox(width: 5)
                                ]),
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Details:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        hintText: 'Details..',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller: model.detailsController),
                                  )),
                                  SizedBox(width: 5)
                                ]),
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Weight in KG:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        textInputType: TextInputType.number,
                                        hintText: 'Enter Weight..',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller: model.weightController),
                                  )),
                                  const SizedBox(width: 5)
                                ]),
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Advance Rent:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        onempty: model.onempty,
                                        textInputType: TextInputType.number,
                                        hintText: 'Advance Payment..',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller:
                                            model.advanceRentController),
                                  )),
                                  const SizedBox(width: 5)
                                ]),
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Total Rent:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        textInputType: TextInputType.number,
                                        hintText: 'Enter total rent...',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller: model.totalRentController),
                                  )),
                                  const SizedBox(width: 5)
                                ]),
                                Row(children: [
                                  Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.center,
                                        child: const Expanded(
                                            child: Text('Condition:- ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      )),
                                  Expanded(
                                      child: SizedBox(
                                    height: 40,
                                    child: RoundedTextField(
                                        hintText: 'Enter Condition..',
                                        verticalPading: 5,
                                        horizontalPadding: 10,
                                        controller: model.conditionController),
                                  )),
                                  const SizedBox(width: 5)
                                ]),
                                const SizedBox(height: 15),
                                // DropdownButton(
                                //   value: model.selectedOption,
                                //   onChanged: (newValue) {
                                //     model.selectedOption = newValue!;
                                //   },
                                //   items: [
                                //     DropdownMenuItem(
                                //       value: model.options[0],
                                //       child: Text(model.options[0]),
                                //     ),
                                //     DropdownMenuItem(
                                //       value: model.options[1],
                                //       child: Text(model.options[1]),
                                //     ),
                                //     DropdownMenuItem(
                                //       value: model.options[2],
                                //       child: Text(model.options[2]),
                                //     ),
                                //   ],
                                // ),
                                // DropdownButton(
                                //   value: model.selectedOption,
                                //   onChanged: (value) {
                                //     model.setSelectedOption(value!);
                                //   },
                                //   items: model.options
                                //       .map(
                                //         (option) => DropdownMenuItem(
                                //           value: option,
                                //           child: Text(option),
                                //         ),
                                //       )
                                //       .toList(),
                                // ),
                                const SizedBox(height: 15),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    model.addRealtimeBuiltyData(context);
                                  },
                                  icon: const Icon(Icons.upload_outlined,
                                      size: 18),
                                  label: const Text("Save Data"),
                                ),
                                const SizedBox(height: 15),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  )));
        });
  }
}
