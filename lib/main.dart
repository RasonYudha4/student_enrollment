import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:student_enrollment/enrollment/enrollment/enrollment_bloc.dart';
import 'package:student_enrollment/enrollment/package/package_bloc.dart';
import 'package:student_enrollment/enrollment/service/enrollment_service.dart';
import 'package:student_enrollment/enrollment/service/package_service.dart';
import 'package:student_enrollment/model/user.dart';
import 'package:student_enrollment/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth Example',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PackageBloc(PackageService()),
                ),
                BlocProvider(
                  create: (context) => EnrollmentBloc(EnrollmentService()),
                ),
              ],
              child: LandingPage(),
            ),
      },
    );
  }
}
