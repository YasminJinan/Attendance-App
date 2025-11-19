import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/wrapper/auth_wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:" AIzaSyBs2llanAU9hABtYJ_q9_nysHNIQ9cgd7o" ,
      appId: "1:619603916475:android:4a6adf6eb7e6dac19edb9e",
      messagingSenderId: "619603916475",
      projectId: "attendance-app-158c1"
    )
  );
  runApp(AttendanceApp());
}
class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(centerTitle: true,
          elevation: 0,
          )
      ),
      home: AuthWrapper(),
    );
  }
}