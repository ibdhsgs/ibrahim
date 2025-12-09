import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'settings_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({Key? key}) : super(key: key);

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = Provider.of<CartProvider>(context).itemCount;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.red),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            selectedIcon: const Icon(Icons.shopping_bag, color: Colors.red),
            label: 'السلة',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Colors.red),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}