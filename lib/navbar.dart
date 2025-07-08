import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/Cart.dart';
import 'package:myapp/Fav.dart';
import 'package:myapp/Order.dart';
import 'package:myapp/Prof.dart';

void main() => runApp(Nav());

class Nav extends StatefulWidget {
  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomePage(), Cart(), Fav(), Order(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontSize: 10), // Size when selected
            unselectedLabelStyle: TextStyle(
              fontSize: 10,
            ), // Size when not selected
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 23),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, size: 23),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 23),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long, size: 23),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 23),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
