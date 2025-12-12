import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://localhost:3000";

  // Login
  Future<Map<String, dynamic>> login({
    required String correo,
    required String contrasenia,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/login");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo": correo,
          "contrasenia": contrasenia,
        }),
      );

      final data = jsonDecode(response.body);

      // Guardar sesión si login exitoso
      if (data['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_nombre', data['user']?['nombre'] ?? '');
        prefs.setString('user_email', data['user']?['correo'] ?? '');
        prefs.setString('token', data['token'] ?? '');
      }

      return data;
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // Register
  Future<Map<String, dynamic>> register({
    required String nombre,
    required String apellidos,
    required String tlf,
    required String correo,
    required String contrasenia,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/register");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nombre": nombre,
          "apellidos": apellidos,
          "tlf": tlf,
          "correo": correo,
          "contrasenia": contrasenia,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // Obtener usuario logeado
  Future<Map<String, String>> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final nombre = prefs.getString('user_nombre') ?? '';
    final correo = prefs.getString('user_email') ?? '';
    final token = prefs.getString('token') ?? '';
    return {"nombre": nombre, "correo": correo, "token": token};
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
