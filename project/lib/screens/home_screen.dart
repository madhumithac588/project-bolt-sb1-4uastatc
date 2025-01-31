import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flora_emosens/providers/plant_provider.dart'; // Correct import path
import 'package:flora_emosens/screens/my_plants_screen.dart';
import 'package:flora_emosens/screens/scanner_screen.dart';
import 'package:flora_emosens/screens/advice_screen.dart';
import 'package:flora_emosens/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _screens = [
    MyPlantsScreen(),
    ScannerScreen(),
    AdviceScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text('Flora EmoSens')
            : Text(_getTitle(_selectedIndex)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotifications(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
        bottom: _selectedIndex == 0
            ? PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search plants',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Filter the plant list based on search input
                      context.read<PlantProvider>().filterPlants(value);
                    },
                  ),
                ),
              )
            : null,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'My Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Advice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 1:
        return 'My Plants';
      case 2:
        return 'Scanner';
      case 3:
        return 'Advice';
      case 4:
        return 'Profile';
      default:
        return 'Flora EmoSens';
    }
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: const Text('No new notifications at the moment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: const [
            ListTile(title: Text('Settings')),
            ListTile(title: Text('Help')),
            ListTile(title: Text('Log out')),
          ],
        );
      },
    );
  }
}
