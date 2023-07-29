import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/login_screen.dart';
import 'package:new_ngcs/Screens/pdf_Screen.dart';
import 'package:new_ngcs/Screens/show_builty_screen.dart';
import 'package:new_ngcs/View_Models/dashboard_view_model.dart';
import 'package:stacked/stacked.dart';

import '../Constants/urduwritings.dart';
import '../CustomWidgets/custom_text_field.dart';
import '../View_Models/registeration_view_model.dart';
import 'Add_Builty_Screen.dart';

class MyDashboardScreen extends StatefulWidget {
  const MyDashboardScreen({super.key});

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreen();
}

class _MyDashboardScreen extends State<MyDashboardScreen> {
  DashboardScreenViewModel dashboardScreeenViewModel =
      DashboardScreenViewModel();
  bool loading = false;
  var file;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardScreenViewModel>.reactive(
        viewModelBuilder: () => dashboardScreeenViewModel,
        onViewModelReady: (model) {
          model.initialize(context);
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: model.checkName == false
                    ? const Text('Welcome Dear $receiverUrdu')
                    : Text('Welcome ${model.name}'),
                actions: [
                  IconButton(
                      onPressed: () {
                        model.logOutUser(context);
                      },
                      icon: const Icon(Icons.logout_outlined))
                ],
              ),
              body: Container(
                alignment: Alignment.topCenter,
                // color: Colors.grey,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        margin: const EdgeInsets.all(20),
                        child: const Card(
                          shape: OutlineInputBorder(),
                          elevation: 10,
                          child: Center(
                            child: Text('This is Slider..'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyShowBuiltyScreen()));
                            },
                            child: const Text('Show Builty Data'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddBuiltyScreen()));
                            },
                            child: const Text('Add Builty Data'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowPDF()));
                            },
                            child: const Text('Terms & Conditions'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Track Vehicle'),
                          ),
                        ],
                      ),
                    ]),
              ));
        });
  }
}
