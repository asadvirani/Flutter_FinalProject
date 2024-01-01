import 'package:crud/firebase_options.dart';
import 'package:crud/repo/auth_repo.dart';
import 'package:crud/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp(FirebaseUserRepository()));
}
