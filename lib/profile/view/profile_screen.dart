import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:student_enrollment/enrollment/enrollment/enrollment_bloc.dart';
import 'package:student_enrollment/enrollment/package/package_bloc.dart';
import 'package:student_enrollment/model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfileScreen());

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the userId from UserModel
    final userId = context.read<UserModel>().userId;
    // Dispatch the GetEnrollment event with the userId
    context.read<EnrollmentBloc>().add(GetEnrollment(userId!));
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<UserModel>().userId;
    final email = context.watch<UserModel>().email;
    return BlocListener<EnrollmentBloc, EnrollmentState>(
      listener: (context, state) {
        if (state is EnrollmentFetchedSuccessfully) {
          // Extract package IDs from the enrollment
          List<String> packageIds = state.enrollment.packageId;

          // Dispatch the GetPackageByUser Id event with the userId and packageIds
          context.read<PackageBloc>().add(GetPackageByUserId(userId));
        }
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Rason Yudha",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        email!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        userId!,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Package Taken",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PackageList()
                    ],
                  ),
                ),
              ),
              const ContactButton(),
              const LanguageButton(),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageList extends StatelessWidget {
  const PackageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        if (state is PackageLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PackageLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.packages.map((package) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: PackageCard(
                    lecturer: package.lecturer,
                    room: package.room,
                    time: package.schedule,
                    title: package.title,
                  ),
                );
              }).toList(),
            ),
          );
        } else if (state is PackageError) {
          return const Text("Fetch error");
        }
        return Container();
      },
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
          color: const Color(0xFF283F61),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
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
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  room,
                  style: const TextStyle(
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
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
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
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
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
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
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
