import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/profile_screen.dart';
import 'package:rukedig/screens/my_courses_screen.dart';
import 'package:rukedig/screens/login_screen.dart';
import 'package:rukedig/screens/notification_screen.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:rukedig/models/user_profile.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;
  
  UserProfile _userProfile = UserProfile(
     firstName: 'Ach Bintang',
     lastName: 'Febrian',
     email: 'user@365.rukedig.ac.id',
     country: 'Indonesia',
     description: 'Mahasiswa Teknik Informatika...',
     profileImagePath: 'assets/images/ab.jpeg',
   );

  void _updateProfile(UserProfile newProfile) {
    setState(() {
      _userProfile = newProfile;
    });
  }

  ImageProvider _getProfileImage() {
    final imagePath = _userProfile.profileImagePath;
    if (imagePath != null) {
      if (imagePath.startsWith('assets/')) {
        return AssetImage(imagePath);
      } else if (imagePath.startsWith('http')) {
        return NetworkImage(imagePath);
      } else {
        return kIsWeb 
            ? NetworkImage(imagePath)
            : FileImage(File(imagePath)) as ImageProvider;
      }
    }
    return const AssetImage('assets/images/ab.jpeg');
  }

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
    final List<Widget> screens = [
      const DashboardContent(),
      const MyCoursesScreen(),
      ProfileScreen(
        userProfile: _userProfile,
        onProfileUpdate: _updateProfile,
      ),
    ];

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
          // Notification icon
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
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
                     child: CircleAvatar(
                       radius: 32,
                       backgroundImage: _getProfileImage(),
                       backgroundColor: Colors.white,
                     ),
                   ),
                   const SizedBox(height: 12),
                   Text(
                    '${_userProfile.firstName} ${_userProfile.lastName}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _userProfile.email,
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
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
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
