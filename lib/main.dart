import 'package:flutter/material.dart';
import 'home_page.dart'; // Importamos tu pantalla de diseño

void main() {
  runApp(const MyApp());
}

// Definición de colores base (para usar en el tema global)
const Color kPrimaryColor = Color(0xFF2F544D); // Verde oscuro para barras

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitalink Inmobiliaria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        // Usar un esquema de color consistente
        appBarTheme: const AppBarTheme(backgroundColor: kPrimaryColor),
        // Puedes definir la fuente aquí si quieres una específica
        fontFamily: 'Roboto',
      ),
      // La primera pantalla que se muestra es tu HomePage
      home: const HomePage(),
    );
  }
}
