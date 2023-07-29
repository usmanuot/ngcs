import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ngcs/Screens/search_test.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:stacked/stacked.dart';
import '../View_Models/show_builty_view_model.dart';

class MyShowBuiltyScreen extends StatefulWidget {
  const MyShowBuiltyScreen({super.key});

  @override
  State<MyShowBuiltyScreen> createState() => _MyShowBuiltyScreen();
}

class _MyShowBuiltyScreen extends State<MyShowBuiltyScreen> {
  ShowBuiltyViewModel showBuiltyViewModel = ShowBuiltyViewModel();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShowBuiltyViewModel>.reactive(
        viewModelBuilder: () => showBuiltyViewModel,
        onViewModelReady: (model) {
          model.initialize(context);
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Details'),
                actions: [
                  Row(
                    children: [
                      // AnimSearchBar(
                      //   width: MediaQuery.of(context).size.width / 2,
                      //   textController: TextEditingController(),
                      //   onSuffixTap: () {
                      //     setState(() {
                      //       TextEditingController().clear();
                      //     });
                      //   },
                      //   onSubmitted: (String) {},
                      // ),
                      SearchBarAnimation(
                        onCollapseComplete: () {
                          model.clicked = true;
                          model.update();
                        },

                        buttonColour:
                            model.clicked ? Colors.blue : Colors.white,
                        searchBoxWidth: MediaQuery.of(context).size.width / 1.2,
                        enableBoxShadow: false,
                        // enableButtonBorder: true,
                        hintText: "Search Builty No",
                        onSaved: (searchText) {
                          // model.searchFilter(searchText);
                        },
                        onChanged: (text) {
                          model.searchFilter(text);
                        },
                        onFieldSubmitted: (searchText) {
                          // model.searchFilter(searchText);
                        },
                        onEditingComplete: (searchText) {
                          // model.searchFilter(searchText);
                        },
                        textEditingController: TextEditingController(),
                        isOriginalAnimation: true,
                        trailingWidget: const Padding(
                          padding: EdgeInsets.only(bottom: 1.0),
                          child: Icon(
                            // size: 20,
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        secondaryButtonWidget:
                            // GestureDetector(
                            // child:
                            const Icon(Icons.clear),
                        // onTap: () {
                        //   model.clicked = false;
                        //   model.update();
                        // }),
                        buttonWidget: const Icon(Icons.search),
                        durationInMilliSeconds: 500,
                        // buttonElevation: 0,
                        // buttonShadowColour: Colors.transparent,
                        // enableButtonShadow: false,
                      ),
                      // AnimSearchBar(
                      //     width: MediaQuery.of(context).size.width / 1.05,
                      //     helpText: 'Search Builty Number',
                      //     color: Colors.blue,
                      //     boxShadow: false,
                      //     textFieldColor: Colors.white,
                      //     textController: TextEditingController(),
                      //     onSuffixTap: () {
                      //       setState(() {
                      //         TextEditingController().clear();
                      //       });
                      //     },
                      //     onSubmitted: (value) {
                      //       model.searchFilter(value);
                      //     }),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                ],
              ),
              body: Container(
                  // alignment: Alignment.topCenter,
                  child: model.filteredData.isNotEmpty
                      ? ListView.builder(
                          itemCount: model.filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            final list = model.filteredData[index];
                            return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                    child: Card(
                                      elevation: 10,
                                      child: ListTile(
                                        title: Text(list.details ?? ''),
                                        subtitle: Text(
                                          list.date ?? '',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(list.builtyNo ?? '')
                                            ]),
                                      ),
                                    ),
                                    onTap: () {
                                      model.generatePdf(context, index);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             MyWidget(model.dataList)));
                                      if (kDebugMode) {
                                        print('List tile clicked');
                                      }
                                    }));
                          },
                        )
                      : const Center(
                          // child: model.containData
                          //     ? const Text('No Data Found')
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.yellow))));
        });
  }
}
