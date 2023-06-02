import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_iquii/screens/pokedex_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    FirebaseFirestore.instance.enablePersistence();
  } else {
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  }
  runApp(ProviderScope(child: const TestIquiiApp()));
}

class TestIquiiApp extends StatelessWidget {
  const TestIquiiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              displayMedium: TextStyle(color: Colors.white, fontSize: 15),
              titleLarge: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
              titleMedium: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              titleSmall: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
              labelSmall: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          primaryColor: const Color.fromRGBO(210, 44, 25, 1),
          primarySwatch: Colors.red,
          fontFamily: GoogleFonts.comfortaaTextTheme().bodySmall!.fontFamily),
      home: PokedexScreen(),
    );
  }
}
