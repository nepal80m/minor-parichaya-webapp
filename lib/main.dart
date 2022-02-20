import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/home_view.dart';
import 'views/expired_link_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parichaya - File Storage and Sharing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: const TextStyle(fontSize: 36, color: Colors.black),
          headline2: const TextStyle(
              fontSize: 48, color: Colors.blue, fontWeight: FontWeight.bold),
          headline3: const TextStyle(fontSize: 20, color: Colors.white),
          subtitle1:
              TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.8)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeView(),
        ExpiredViewLink.routeName: (context) => const ExpiredViewLink(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const ExpiredViewLink(),
        );
      },
    );
  }
}
