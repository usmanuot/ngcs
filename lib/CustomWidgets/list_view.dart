import 'package:flutter/material.dart';

class DecoratedListView extends StatelessWidget {
  final List<String> items;
  DecoratedListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color for the list
      ),
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0, // Elevation for a card-like effect
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            // child: Text('data'),
            child: ListTile(
              title: Text(items[index], style: const TextStyle(fontSize: 18.0)),
              leading: CircleAvatar(
                backgroundColor: Colors.blue, // Customize the avatar color
                child: Text(
                  items[index][0].toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Action when a list item is tapped
                // You can navigate to a new screen or perform any other action here.
              },
            ),
          );
        },
      ),
      // child: ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: Text(items.last),
      //     );
      //   },
      // )
    );
  }
}
