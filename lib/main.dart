import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart'; // <-- 1. IMPORTAMOS LA PÁGINA DE REGISTRO

void main() {
  runApp(const MyApp());
}

const Color kPrimaryColor = Color(0xFF2F544D);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitalink Inmobiliaria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(backgroundColor: kPrimaryColor),
        fontFamily: 'Roboto',
      ),
      
      // --- 2. CONFIGURAMOS LAS RUTAS ---
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/registro': (context) => const RegisterPage(), // <-- 3. AÑADIMOS LA RUTA
      },
      // -------------------------------
    );
  }
}