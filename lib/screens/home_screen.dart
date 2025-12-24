import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/profile_screen.dart';
import 'package:rukedig/screens/my_courses_screen.dart';
import 'package:rukedig/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    const DashboardContent(),
    const MyCoursesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Dashboard'
              : _selectedIndex == 1
                  ? 'Kelas Saya'
                  : 'Profil Pengguna',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF9800),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Show profile icon only if not on profile tab
          if (_selectedIndex != 2)
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2; // Switch to Profile Tab
                });
              },
            ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFF9800),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   GestureDetector(
                     onTap: () {
                        setState(() => _selectedIndex = 2); // Switch to Profile
                        Navigator.pop(context); // Close Drawer
                     },
                     child: Container(
                       padding: const EdgeInsets.all(8),
                       decoration: const BoxDecoration(
                         shape: BoxShape.circle,
                         color: Colors.white,
                       ),
                       child: const Icon(Icons.person, color: Color(0xFFFF9800), size: 32),
                     ),
                   ),
                   const SizedBox(height: 12),
                   Text(
                    'User Name',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'user@365.rukedig.ac.id',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text('Dashboard', style: GoogleFonts.poppins()),
              selected: _selectedIndex == 0,
              selectedColor: const Color(0xFFFF9800),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: Text('Kelas Saya', style: GoogleFonts.poppins()),
              selected: _selectedIndex == 1,
              selectedColor: const Color(0xFFFF9800),
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('About Me', style: GoogleFonts.poppins()),
              selected: _selectedIndex == 2,
              selectedColor: const Color(0xFFFF9800),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: GoogleFonts.poppins(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.of(context).pushAndRemoveUntil(
                   MaterialPageRoute(builder: (_) => const LoginScreen()),
                   (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Kelas Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF9800),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Welcome, User!',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a course from the menu to start.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
