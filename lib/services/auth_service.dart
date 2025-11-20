import 'dart:convert';
import 'package:http/http.dart' as http;

// ⚠️ IMPORTANTE: Ajusta esta URL a la IP de tu PC si usas un emulador o dispositivo físico
// 10.0.2.2 es el alias para 'localhost' en emuladores de Android.
const String _baseUrl = 'http://10.0.2.2:3000/api'; 

class AuthService {
  // ----------------------------------------------------
  // 🔑 REGISTRO
  // ----------------------------------------------------
  Future<Map<String, dynamic>> register({
    required String nombre,
    required String correo,
    required String password,
    required String apellidos, // Necesario para el backend de Node
    required String tlf, // Necesario para el backend de Node
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/registro'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombre': nombre,
          'apellidos': apellidos,
          'tlf': tlf,
          'correo': correo,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'message': data['message']};
      } else {
        // Maneja errores 400 (Faltan campos) o 409 (Correo ya existe)
        return {'success': false, 'message': data['message'] ?? 'Error desconocido en el registro.'};
      }
    } catch (e) {
      print('Error de conexión/petición en registro: $e');
      return {'success': false, 'message': 'No se pudo conectar con el servidor. Verifica la URL.'};
    }
  }

  // ----------------------------------------------------
  // 🔓 LOGIN
  // ----------------------------------------------------
  Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': correo,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true, 
          'message': data['message'],
          'token': data['token'],
          'user': data['user'],
        };
      } else {
        // Maneja errores 401 (Credenciales inválidas)
        return {'success': false, 'message': data['message'] ?? 'Error desconocido al iniciar sesión.'};
      }
    } catch (e) {
      print('Error de conexión/petición en login: $e');
      return {'success': false, 'message': 'No se pudo conectar con el servidor. Verifica la URL.'};
    }
  }
}