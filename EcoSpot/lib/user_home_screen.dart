import 'package:flutter/material.dart';
import 'user_camera_screen.dart';
import 'user_rewards_screen.dart';
import 'user_settings_screen.dart';
import 'user_Tips_and_Quotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  final List<Widget> _screens = [
    const CameraScreen(),
    const RewardsScreen(),
    const SettingsScreen(),
    const TipsAndQuotesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: List.generate(4, (index) {
              return BottomNavigationBarItem(
                icon: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = -1),
                  child: Icon(
                    _getIconForIndex(index),
                    color: (_hoveredIndex == index) ? Colors.green : Colors.grey,
                  ),
                ),
                label: _getLabelForIndex(index),
              );
            }),
          ),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.settings;
      case 3:
        return Icons.eco;
      default:
        return Icons.help;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Rewards';
      case 2:
        return 'Settings';
      case 3:
        return 'Tips and Quotes';
      default:
        return '';
    }
  }
}
