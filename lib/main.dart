// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie_detailer/view/detail_page.dart';
import 'package:movie_detailer/view/home_page.dart';
import 'package:movie_detailer/view/liked_page.dart';

import 'package:movie_detailer/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/movie_provider.dart';
import 'controller/search_provider.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: "Movie Bazaar",
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => Splash(),
          "Home": (context) => Home_screen(),
          "ViewMore": (context) => ViewMore(),
          "LikePage": (context) => LikePage(),
        },
      ),
    );
  }
}
