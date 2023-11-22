import 'package:flutter/material.dart';
import 'package:fyp/home/home.dart';
import 'package:fyp/inventory/All_inventory.dart';
import 'package:fyp/inventory/pending_inventory.dart';
import 'package:fyp/inventory/sold_niventory.dart';
import 'package:fyp/user%20profile/user_profile.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  @override
  int _currentIndex = 1;

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Inventory",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.green,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Active',
                icon: Icon(Icons.sell),
              ),
              Tab(
                child: Text('Sold'),
                icon: Icon(Icons.done),
              ),
              Tab(
                text: 'Pending',
                icon: Icon(Icons.pending),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllProduct(),
            SoldProduct(),
            PendingProduct(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InventoryTab(),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
