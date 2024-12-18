import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_enrollment/pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfileScreen());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: ,
              width: double.infinity,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20), color: Colors.grey),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Rason Yudha",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "rason.nugraha@student.president.ac.id",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "001202300111",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Package Taken",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PackageCard(
                            lecturer: "Cutifa Safitri",
                            room: "A215",
                            time: "07.30 - 09.45",
                            title: "Artificial Intelligence",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PackageCard(
                            lecturer: "Cutifa Safitri",
                            room: "A215",
                            time: "07.30 - 09.45",
                            title: "Artificial Intelligence",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PackageCard(
                            lecturer: "Cutifa Safitri",
                            room: "A215",
                            time: "07.30 - 09.45",
                            title: "Artificial Intelligence",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ContactButton(),
            LanguageButton(),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String lecturer;
  final String title;
  final String room;
  final String time;
  const PackageCard({
    super.key,
    required this.lecturer,
    required this.title,
    required this.room,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 280,
      decoration: BoxDecoration(
          color: Color(0xFF283F61), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecturer,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  room,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  Icons.language,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Change Language",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
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
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
