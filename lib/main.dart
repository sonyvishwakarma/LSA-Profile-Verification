import 'package:flutter/material.dart';
import 'screens/lsa_profile_verification_screen.dart';

void main() {
  runApp(const HabotLsaVerificationApp());
}

class HabotLsaVerificationApp extends StatelessWidget {
  const HabotLsaVerificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habot LSA Verification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const LsaProfileVerificationScreen(),
    );
  }
}