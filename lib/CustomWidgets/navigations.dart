import 'package:flutter/material.dart';

class CustomNavigator extends StatefulWidget {
  final List<Widget> pages;

  CustomNavigator({required this.pages});

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator> {
  int _currentPageIndex = 0;

  void _navigateForward() {
    if (_currentPageIndex < widget.pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  void _navigateBack() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: widget.pages
            .map((page) => const BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward),
                  label:
                      '', // Optional label, you can customize this if needed.
                ))
            .toList(),
      ),
    );
  }
}
