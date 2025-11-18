import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart'; // <-- 1. IMPORTAMOS LA PÁGINA DE REGISTRO
import 'theme/colors.dart';
import 'pages/search_results_page.dart';

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
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary),
        fontFamily: 'Roboto',
      ),

      // 2. CONFIGURAMOS LAS RUTAS
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/registro': (context) => const RegisterPage(), //3. AÑADIMOS LA RUTA
        '/search_results': (context) => const SearchResultsPage(),
      },
    );
  }
}
