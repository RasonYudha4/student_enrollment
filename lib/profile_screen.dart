import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_enrollment/pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfileScreen());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Default Profile Content',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
