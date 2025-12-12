import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart'; 
import '../services/auth_service.dart';

final AuthService _authService = AuthService();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppColors.kPadding, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home,
                        color: AppColors.primary, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    tooltip: 'Volver a la página principal',
                  ),
                  Image.asset(
                    'assets/logo/LogoSinFondo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Container(
              color: AppColors.primary,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  NavMenuItem(title: 'Comprar'),
                  NavMenuItem(title: 'Alquilar'),
                  NavMenuItem(title: 'Valoración'),
                  NavMenuItem(title: 'Favoritos'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppColors.kPadding),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showMessageDialog(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final result = await _authService.login(
      correo: _emailController.text.trim(),
      contrasenia: _passwordController.text,
    );

    if (result['success'] == true) {
      // Guardar datos del usuario en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', result['user']['nombre']); // Guardamos nombre

      _showMessageDialog(result['message'], true);

      // Navegar a HomePage y reemplazar la ruta para que no vuelva al login
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      _showMessageDialog(result['message'], false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.iconColor,
                size: 60,
              ),
            ),
            const SizedBox(height: 30),
            _LoginTextField(
              controller: _emailController, 
              hintText: 'Usuario@gmail.com',
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 20),
            _LoginTextField(
              controller: _passwordController, 
              hintText: '.........',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Olvidé mi contraseña ↗',
                  style: TextStyle(color: AppColors.iconColor, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
              child: const Text(
                'Crear cuenta ↗',
                style: TextStyle(color: AppColors.iconColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller; 

  const _LoginTextField({
    required this.hintText,
    required this.icon,
    required this.controller, 
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
        prefixIcon: Icon(icon, color: AppColors.iconColor),
        filled: true,
        fillColor: AppColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      ),
    );
  }
}

class NavMenuItem extends StatelessWidget {
  final String title;
  const NavMenuItem({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16)),
    );
  }
}
