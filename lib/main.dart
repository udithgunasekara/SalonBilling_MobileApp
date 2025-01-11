import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:salon_mobile/View/home_view.dart';
import 'package:salon_mobile/ViewModel/home_view_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Enable Firestore persistance on caching purposes
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Billing App',
      theme: ThemeData(
        //added google font :)
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'ProductSans'),
          bodyMedium: TextStyle(fontFamily: 'ProductSans'),
          displayLarge: TextStyle(fontFamily: 'ProductSans'),
          displayMedium: TextStyle(fontFamily: 'ProductSans'),
          displaySmall: TextStyle(fontFamily: 'ProductSans'),
          headlineMedium: TextStyle(fontFamily: 'ProductSans'),
          headlineSmall: TextStyle(fontFamily: 'ProductSans'),
          titleLarge: TextStyle(fontFamily: 'ProductSans'),
          titleMedium: TextStyle(fontFamily: 'ProductSans'),
          titleSmall: TextStyle(fontFamily: 'ProductSans'),
          bodySmall: TextStyle(fontFamily: 'ProductSans'),
          labelLarge: TextStyle(fontFamily: 'ProductSans'),
          labelSmall: TextStyle(fontFamily: 'ProductSans'),
        ),
      ),
      home: HomeView(HomeViewModel()),
    );
  }
}
