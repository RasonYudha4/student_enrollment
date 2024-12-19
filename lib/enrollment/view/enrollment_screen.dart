import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_enrollment/enrollment/enrollment/enrollment_bloc.dart';
import 'package:student_enrollment/enrollment/package/package_bloc.dart';
import 'package:student_enrollment/model/enrollment.dart';
import 'package:student_enrollment/model/package.dart';
import 'package:student_enrollment/model/user.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({super.key});

  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().add(GetAllPackage());
  }

  List<Package> packages = [];
  List<bool> selectedPackages = [];
  List<String> selectedPackageIds = [];

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<UserModel>().userId;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: BlocBuilder<PackageBloc, PackageState>(
        builder: (context, state) {
          if (state is PackageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackageError) {
            return const Center(child: Text("Unable to fetch the package"));
          } else if (state is PackageLoaded) {
            final packages = state.packages;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 370,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Enrollment Page",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "The Enrollment Page serves as a central hub for students to manage their course registration and academic planning within the campus. This page provides an intuitive interface where students can view available courses, check prerequisites, and enroll in classes for the upcoming semester. Since the maximum credit is 24, therefore each student can only choose 8 packages at the most",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF283F61), width: 4),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Packages",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Choose the Select Package for your upcoming semester and take charge of your academic success! ",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: packages.length,
                            itemBuilder: (context, index) {
                              final package = packages[index];
                              if (selectedPackages.length < packages.length) {
                                selectedPackages.add(false);
                              }
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!selectedPackages[index]) {
                                          if (selectedPackageIds.length < 8) {
                                            selectedPackages[index] = true;
                                            selectedPackageIds.add(package.id!);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'You can select a maximum of 8 packages.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        } else {
                                          selectedPackages[index] = false;
                                          selectedPackageIds.remove(package.id);
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 90,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF283F61),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14,
                                            left: 20,
                                            bottom: 14,
                                            right: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(package.title,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(package.lecturer,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90)),
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      color: selectedPackages[
                                                              index]
                                                          ? Colors.green
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  )
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Enrollment enrollment = Enrollment(
                        userId: userId,
                        packageId: selectedPackageIds,
                      );
                      context
                          .read<EnrollmentBloc>()
                          .add(CreateEnrollment(enrollment));
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xFF283F61),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Enroll",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 10,
            );
          }
        },
      ),
    );
  }
}
