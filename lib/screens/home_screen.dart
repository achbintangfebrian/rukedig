import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/profile_screen.dart';
import 'package:rukedig/screens/my_courses_screen.dart';
import 'package:rukedig/screens/login_screen.dart';
import 'package:rukedig/screens/notification_screen.dart';
import 'package:rukedig/screens/announcements_screen.dart';
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
            ListTile(
              leading: const Icon(Icons.campaign),
              title: Text('Pengumuman', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnnouncementsScreen()),
                );
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeader(context),
          const SizedBox(height: 24),
          
          // Quick Actions
          _buildQuickActions(context),
          const SizedBox(height: 24),
          
          // Activity Summary
          _buildSectionTitle('Aktivitas Akademik'),
          const SizedBox(height: 12),
          _buildActivitySummary(),
          const SizedBox(height: 24),
          
          // Latest Announcements
          _buildSectionTitle('Pengumuman Terbaru'),
          const SizedBox(height: 12),
          _buildLatestAnnouncements(context),
          const SizedBox(height: 24),
          
          // Class Progress
          _buildSectionTitle('Progres Kelas'),
          const SizedBox(height: 12),
          _buildClassProgress(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF9800),
            const Color(0xFFFF9800).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 35, color: const Color(0xFFFF9800)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang! 👋',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                Text(
                  'Ach Bintang Febrian',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'S1 Teknologi Informatika',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            context: context,
            icon: Icons.notifications_active,
            label: 'Notifikasi',
            count: '5',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionCard(
            context: context,
            icon: Icons.book,
            label: 'Kelas Saya',
            count: '5',
            onTap: () {
              // Switch to My Classes tab (index 1)
              if (context.findAncestorStateOfType<_HomeScreenState>() != null) {
                context.findAncestorStateOfType<_HomeScreenState>()!.setState(() {
                  context.findAncestorStateOfType<_HomeScreenState>()!._onItemTapped(1);
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFF9800), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9800).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFFF9800), size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF9800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildActivitySummary() {
    return Column(
      children: [
        _buildActivityCard(
          icon: Icons.assignment_turned_in,
          iconColor: Colors.green,
          title: 'Tugas Dikumpulkan',
          value: '12',
          subtitle: 'Semester ini',
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          icon: Icons.schedule,
          iconColor: Colors.orange,
          title: 'Deadline Terdekat',
          value: '3 Hari',
          subtitle: 'Quiz Mobile Programming',
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          icon: Icons.check_circle,
          iconColor: Colors.blue,
          title: 'Kehadiran',
          value: '95%',
          subtitle: 'Rata-rata semester ini',
        ),
      ],
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestAnnouncements(BuildContext context) {
    return Column(
      children: [
        _buildAnnouncementItem(
          context: context,
          title: 'Maintenance Pra UAS',
          date: '10 Jan 2026',
          type: 'PENTING',
        ),
        const SizedBox(height: 8),
        _buildAnnouncementItem(
          context: context,
          title: 'Pengumuman Maintenance',
          date: '20 Jan 2026',
          type: 'INFO',
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AnnouncementsScreen()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lihat Semua Pengumuman',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF9800),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward, size: 16, color: Color(0xFFFF9800)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementItem({
    required BuildContext context,
    required String title,
    required String date,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: type == 'PENTING' ? const Color(0xFFFF9800) : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: type == 'PENTING' ? const Color(0xFFFF9800) : Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              type,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassProgress() {
    final courses = [
      {'name': 'Cyber Security', 'progress': 0.75},
      {'name': 'Kecerdasan Buatan', 'progress': 0.60},
      {'name': 'Mobile Programming', 'progress': 0.85},
      {'name': 'Data Mining', 'progress': 0.50},
    ];

    return Column(
      children: courses.map((course) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${((course['progress'] as double) * 100).toInt()}%',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF9800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: course['progress'] as double,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

