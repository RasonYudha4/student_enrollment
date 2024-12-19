import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_enrollment/home/view/home_screen.dart';
import 'package:student_enrollment/model/user.dart';
import 'package:student_enrollment/pages.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget _currentBody = HomeScreen();

  void _updateBody(Widget newBody) {
    setState(() {
      _currentBody = newBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<UserModel>().userId; // Access user ID
    final email = context.watch<UserModel>().email;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: const Color(0xFF283F61),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white), // Drawer icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          }),
          title: Row(
            children: [
              const SizedBox(
                width: 120,
              ),
              GestureDetector(
                onTap: () {
                  _updateBody(HomeScreen());
                },
                child: Image.asset(
                  'assets/President_University_Logo.png',
                  height: 40,
                ),
              ),
            ],
          )),
      drawer: Drawer(
        // Your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF283F61),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile Page'),
              onTap: () {
                _updateBody(ProfileScreen());
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Enrollment Page'),
              onTap: () {
                _updateBody(EnrollmentScreen());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentBody,
    );
  }
}
