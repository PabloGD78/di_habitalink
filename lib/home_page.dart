import 'package:flutter/material.dart';

// Definición de colores base (para usar en esta pantalla)
const Color _kPrimaryColor = Color(0xFF2F544D); // Verde oscuro
const Color _kAccentColor = Color(0xFFE9C589); // Tono crema/beige (simulado)
const Color _kBackgroundColor = Color(0xFFF7F7F7); // Fondo ligero

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      // 1. BARRA SUPERIOR (AppBar)
      appBar: AppBar(
        // El color ya lo toma del theme en main.dart, pero se puede redefinir
        elevation: 0,
        title: const Text(
          'HABITALINK', // Logo
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          // Botones "Inicio" y "Sesión"
          TextButton(
            onPressed: () {},
            child: const Text(
              'Inicio',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Sesión',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        // 1.1 Menú de Navegación debajo del AppBar
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavMenuItem(title: 'Comprar'),
              _NavMenuItem(title: 'Alquilar'),
              _NavMenuItem(title: 'Valoración'),
              _NavMenuItem(title: 'Favoritos'),
            ],
          ),
        ),
      ),

      // 2. CUERPO DE LA PÁGINA (Body)
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2.1 Mensaje de Bienvenida
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Conecta con tu espacio ideal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: _kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2.2 Barra de Búsqueda y Filtros
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _SearchBarWidget(),
            ),
            const SizedBox(height: 40),

            // 2.3 Sección de Exploración Títulos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Explora nuevas posibilidades',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _kPrimaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Inspírate con las mejores opciones de vivienda.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // 2.4 Lista Horizontal de Propiedades (Slider)
            SizedBox(
              height: 350, // Altura necesaria para las tarjetas
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: const [
                  _PropertyCard(
                    // Aquí deberías poner tus imágenes
                    imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
                    title:
                        'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                    price: '380.000€',
                  ),
                  _PropertyCard(
                    imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
                    title:
                        'Casa o chalet Independiente en venta en Santa Cruz - Alfalfa Centro, Sevilla',
                    price: '3.400.000€',
                  ),
                  _PropertyCard(
                    imageUrl: 'assets/casa3.png',
                    title: 'Apartamento de lujo con vistas al mar',
                    price: '1.200.000€',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 3. PIE DE PÁGINA (FOOTER)
      bottomNavigationBar: const _FooterWidget(),
    );
  }
}

// --- WIDGETS AUXILIARES ---

// Widget auxiliar para el menú de navegación
class _NavMenuItem extends StatelessWidget {
  final String title;
  const _NavMenuItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Widget para la barra de búsqueda y filtros
class _SearchBarWidget extends StatelessWidget {
  const _SearchBarWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      // El color de fondo claro (crema) para el input
      decoration: BoxDecoration(
        color: _kAccentColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Botón Filtrar
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_down, color: _kPrimaryColor),
            label: const Text(
              'Filtrar',
              style: TextStyle(color: _kPrimaryColor),
            ),
          ),
          // Línea divisoria simulada (usualmente no se usa VerticalDivider en Row/Container)
          Container(width: 1, height: 20, color: Colors.grey[400]),
          const SizedBox(width: 8),

          // Campo de Búsqueda
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar vivienda, municipio...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),

          // Botón de Lupa
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: _kPrimaryColor),
          ),
        ],
      ),
    );
  }
}

// Widget para la tarjeta de propiedad (Property Card)
class _PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const _PropertyCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              // Fallback en caso de que la imagen no exista (solo para demostración)
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),

          // Contenido de la tarjeta
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2, // Ajustado para dos líneas
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Botón "más detalles"
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Row(
                        children: [
                          Text(
                            'más detalles',
                            style: TextStyle(
                              color: _kPrimaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: _kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para el Pie de Página (Footer)
class _FooterWidget extends StatelessWidget {
  const _FooterWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPrimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contacta con nosotros',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const _ContactItem(icon: Icons.phone, text: '+34 241 85 39 23'),
          const SizedBox(height: 5),
          const _ContactItem(icon: Icons.email, text: 'habitalink@gmail.com'),
          // Aquí puedes agregar un logo o más texto de pie de página
        ],
      ),
    );
  }
}

// Widget auxiliar para los ítems de contacto
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
