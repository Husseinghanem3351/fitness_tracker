import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.light,
    primary: Colors.indigo,
    onPrimary: Colors.white,
    secondary: Colors.blueGrey,
    onSecondary: Colors.white,
    surface: Colors.white,
    background: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.indigo,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.indigo),
  ),
  cardTheme: const CardThemeData( // Changed to CardThemeData
    color: Colors.white,
    elevation: 4,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[50],
    labelStyle: TextStyle(color: Colors.blueGrey[600], fontSize: 14),
    hintStyle: TextStyle(color: Colors.blueGrey[300], fontSize: 14),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.indigo, width: 2),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    labelMedium: TextStyle(color: Colors.blueGrey, fontSize: 13),
    bodySmall: TextStyle(color: Colors.blueGrey, fontSize: 14),
    bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF2D3142)),
    titleMedium: TextStyle(color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22, color: Colors.indigo, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
    primary: Colors.indigoAccent[100]!, // Vibrant Indigo Accent
    onPrimary: Colors.black,
    secondary: const Color(0xFF3D4452), // BlueGrey tone
    onSecondary: Colors.white,
    surface: const Color(0xFF37474F), // Lighter BlueGrey dark surface (blueGrey[800])
    background: const Color(0xFF0B0E11), // Deep foundation
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0B0E11),
    elevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: const CardThemeData(
    color: Color(0xFF37474F), // Unified light blue-grey card color
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withOpacity(0.05),
    labelStyle: TextStyle(color: Colors.blueGrey[200], fontSize: 14),
    hintStyle: TextStyle(color: Colors.blueGrey[600], fontSize: 14),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.indigo[300]!, width: 2),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF121416),
  textTheme: const TextTheme(
    labelMedium: TextStyle(color: Colors.blueGrey, fontSize: 13),
    bodySmall: TextStyle(color: Colors.white70, fontSize: 14),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
    titleMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
  ),
);
