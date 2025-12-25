// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rukedig/main.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rukedig/main.dart';

import 'package:rukedig/screens/login_screen.dart';
import 'package:rukedig/screens/login_instructions_screen.dart';
import 'package:rukedig/screens/edit_profile_screen.dart';
import 'package:rukedig/models/user_profile.dart';
import 'package:rukedig/screens/home_screen.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RukedigApp());

    // Verify that the splash screen shows the logo text.
    expect(find.text('rukedig'), findsOneWidget);
    expect(find.text('Learning Management System'), findsOneWidget);
  });

  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build LoginScreen wrapped in MaterialApp
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify presence of key text and fields
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Email 365'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Butuh Bantuan?'), findsOneWidget);
  });

  testWidgets('Login instructions smoke test', (WidgetTester tester) async {
    // Build LoginInstructionsScreen wrapped in MaterialApp
    await tester.pumpWidget(const MaterialApp(home: LoginInstructionsScreen(initialLanguage: 'ID')));

    // Verify initial ID content
    expect(find.text('Instruksi Login'), findsOneWidget);
    expect(find.text('Pernyataan Akses'), findsOneWidget);
    expect(find.text('Panduan Akun'), findsOneWidget);
    
    // Switch to EN
    await tester.tap(find.text('EN'));
    await tester.pump();
    
    // Verify EN content
    expect(find.text('Login Instructions'), findsOneWidget);
    expect(find.text('Access Statement'), findsOneWidget);
  });

  testWidgets('Login navigation test', (WidgetTester tester) async {
    // Build LoginScreen
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Find and tap login button
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify Dashboard/Home content
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Welcome, User!'), findsOneWidget);
  });

  testWidgets('Profile Screen test', (WidgetTester tester) async {
    final mockProfile = UserProfile(
      firstName: 'Test',
      lastName: 'User',
      email: 'test@example.com',
      country: 'Test Country',
      description: 'Test Description',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileScreen(
          userProfile: mockProfile,
          onProfileUpdate: (p) {},
        ),
      ),
    ));// Verify User Details
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('S1 Teknologi Informatika'), findsOneWidget);
    expect(find.text('TEKNIK'), findsOneWidget);

    // Verify Activity
    expect(find.text('Aktivitas Login'), findsOneWidget);
    expect(find.text('24 Desember 2025'), findsOneWidget);
    expect(find.text('1 Januari 2026'), findsOneWidget);
    
    // Tap Edit Profile
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    // Verify Edit Profile Screen
    expect(find.text('Ubah Profil'), findsOneWidget);
    expect(find.text('Nama Pertama'), findsOneWidget);
    
    // NOTE: Simulating text entry and save would require more complex test setup 
    // involving finding TextField widgets by Key or Type. 
    // For now, we verify the screen opens correctly.
  });

  testWidgets('Bottom Navigation test', (WidgetTester tester) async {
    // Build HomeScreen
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify initial state (Dashboard)
    expect(find.text('Welcome, User!'), findsOneWidget);

    // Tap "Kelas Saya"
    await tester.tap(find.text('Kelas Saya').last); // .last because it might be in drawer too/text duplication
    await tester.pumpAndSettle();

    // Verify Courses Screen
    expect(find.text('Kecerdasan Buatan'), findsOneWidget);

    // Tap "About Me"
    await tester.tap(find.text('About Me'));
    await tester.pumpAndSettle();

    // Verify Profile Screen
    expect(find.text('Ach Bintang Febrian'), findsOneWidget);
  });
}
