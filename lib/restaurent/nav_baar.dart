import 'package:flutter/material.dart';
import '../order_online/order_online.dart';
import '../restaurent/book_your_table.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;  // Updated to int

  // Constructor to accept initial index (default is 0 if not passed)
  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;  // For managing the selected tab

  // Navigator Keys for each tab
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> screens = [
    const BookYourTable(



    ), // Index 0
    const OrderOnline(),   // Index 1
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
      // Set initial tab based on passed index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xffF5A302),
        onTap: (index) {
          if (index == currentIndex) {
            // If user taps the same tab again, pop to first screen
            navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
          } else {
            setState(() {
              currentIndex = index;  // Update current index
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/order.png"),
            activeIcon: Image.asset("assets/images/activeorder.png"),
            label: "Book a Table",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/online.png"),
            activeIcon: Image.asset("assets/images/active_online.png"),
            label: "Order Online",
          ),
        ],
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: navigatorKeys[index],  // Unique key for each tab
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => screens[index],
          );
        },
      ),
    );
  }
}
