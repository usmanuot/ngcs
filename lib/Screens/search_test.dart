import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/list_view.dart';
import '../Data_Models/show_data_model.dart';

class MyWidget extends StatefulWidget {
  // List<ShowDataModel> showDataList = [];
  const MyWidget({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  List<ShowDataModel> filteredList = []; // Filtered list based on search query
  TextEditingController searchController = TextEditingController();
  List<String> items = ["Usman", "Naseer", "Faizan", "Bilal"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Check'), actions: []),
      body: DecoratedListView(items: items),
    );
  }

  void filterList(String searchQuery) {
    setState(() {
      // filteredList = widget.showDataList
      //     .where((item) =>
      //         item.builtyNo!.toLowerCase().contains(searchQuery.toLowerCase()))
      //     .toList();
    });
  }
}
