import 'package:flutter/material.dart';

// --- Colores y Constantes (Idénticos a login_page.dart) ---
const Color kPrimaryColor = Color(0xFF2F544D);
const Color kAccentColor = Color(0xFFE9C589);
const Color kPageBackgroundColor = Color(0xFFFBF6EF);
const Color kLoginCardColor = Color(0xFFFEF7E9);
const Color kTextFieldColor = Color(0xFFFBEBCF);
const Color kIconColor = Color(0xFFB99A70);
const Color kHintTextColor = Color(0xFFB99A70);
const double kPadding = 24.0;

// --- Widget Principal de la Página ---

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      // AppBar idéntica (Logo, Home, Nav)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kPadding, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home,
                        color: kPrimaryColor, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    tooltip: 'Volver a la página principal',
                  ),
                  Image.asset(
                    'assets/logo/LogoSinFondo.png', // Misma ruta del logo
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 48), // Spacer
                ],
              ),
            ),
            Container(
              color: kPrimaryColor,
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
      // Cuerpo de la página de Registro
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child:
              const _RegisterForm(), // Widget privado para el formulario de registro
        ),
      ),
    );
  }
}

// --- Widgets del Formulario ---

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: kLoginCardColor,
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
            // 1. Icono de Usuario (igual)
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: kAccentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: kIconColor,
                size: 60,
              ),
            ),
            const SizedBox(height: 30),

            // 2. Campo Usuario
            const _RegisterTextField(
              hintText: 'Nombre de usuario',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),

            // 3. Campo Email
            const _RegisterTextField(
              hintText: 'Usuario@gmail.com',
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 20),

            // 4. Campo Contraseña
            const _RegisterTextField(
              hintText: 'Contraseña',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 20),

            // 5. Campo Confirmar Contraseña
            const _RegisterTextField(
              hintText: 'Confirmar contraseña',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 30),

            // 6. Botón Crear Cuenta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Lógica de registro
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor, // Verde oscuro
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Crear cuenta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 7. Link a Iniciar sesión
            TextButton(
              onPressed: () {
                // Volver a la página de login
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Iniciar sesión ↗',
                style: TextStyle(color: kIconColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widgets Auxiliares ---

/// Un TextField personalizado (copiado de login_page.dart)
class _RegisterTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const _RegisterTextField({
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: kHintTextColor),
        prefixIcon: Icon(icon, color: kIconColor),
        filled: true,
        fillColor: kTextFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none, // Sin borde
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      ),
    );
  }
}

/// Widget para el menú de navegación (copiado de login_page.dart)
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