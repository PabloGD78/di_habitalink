import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://localhost:3000"; 
  // Si usas web → http://localhost:3000

  // -------------------------
  // LOGIN
  // -------------------------
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

      return jsonDecode(response.body);

    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // -------------------------
  // REGISTER
  // -------------------------
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
}
