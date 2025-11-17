import 'package:flutter/material.dart';
import 'dart:math' as math;

// Colores base
const Color _kPrimaryColor = Color(0xFF2F544D); // Verde oscuro
const Color _kAccentColor = Color(0xFFE9C589); // Crema/beige
const Color _kBackgroundColor = Color(0xFFF7F7F7); // Fondo ligero
const double kPadding = 24.0;
const double kMargin = 20.0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = math.min(300.0, screenWidth * 0.25); // Tarjetas proporcionales
    final cardHeight = cardWidth * 1.5;

    return Scaffold(
      backgroundColor: _kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          children: [
            // Fila superior: logo centrado y botón de iniciar sesión a la derecha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 8),
              child: Row(
                children: [
                  const Spacer(),
                  // Logo centrado
                  Center(
                    child: Image.asset(
                      'assets/logo/LogoSinFondo.png', // <-- PON AQUÍ TU IMAGEN
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: _kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Menú fino
            Container(
              color: _kPrimaryColor,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _NavMenuItem(title: 'Comprar'),
                  _NavMenuItem(title: 'Alquilar'),
                  _NavMenuItem(title: 'Valoración'),
                  _NavMenuItem(title: 'Favoritos'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bienvenida
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: const Text(
                'Conecta con tu espacio ideal',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: _kPrimaryColor),
              ),
            ),
            const SizedBox(height: 30),

            // SearchBar con dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: SizedBox(height: 60, child: _SearchBarWidget()),
            ),
            const SizedBox(height: 40),

            // Sección de exploración
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: const Text(
                'Explora nuevas posibilidades',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _kPrimaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: const Text(
                'Inspírate con las mejores opciones de vivienda.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Lista Horizontal de Propiedades centrada
            SizedBox(
              height: cardHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final totalCardsWidth = 2 * cardWidth + kMargin;
                  final horizontalPadding = (screenWidth - totalCardsWidth) / 2;
                  final safePadding = horizontalPadding > kPadding ? horizontalPadding : kPadding;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: safePadding),
                      child: Row(
                        children: [
                          _PropertyCard(
                            imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
                            title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                            price: '380.000€',
                            cardWidth: cardWidth,
                            cardHeight: cardHeight,
                          ),
                          const SizedBox(width: kMargin),
                          _PropertyCard(
                            imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
                            title: 'Casa o chalet Independiente en venta en Santa Cruz - Alfalfa Centro, Sevilla',
                            price: '3.400.000€',
                            cardWidth: cardWidth,
                            cardHeight: cardHeight,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const _FooterWidget(compact: true),
    );
  }
}

// --- Widgets Auxiliares ---

class _NavMenuItem extends StatelessWidget {
  final String title;
  const _NavMenuItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
    );
  }
}

// SearchBar con dropdown de filtros
class _SearchBarWidget extends StatefulWidget {
  const _SearchBarWidget();

  @override
  State<_SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<_SearchBarWidget> {
  String selectedFilter = 'Vivienda';
  final List<String> filters = ['Vivienda', 'Obra Nueva', 'Oficina', 'Garaje', 'Localidad'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: _kAccentColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter,
              icon: const Icon(Icons.keyboard_arrow_down, color: _kPrimaryColor, size: 26),
              dropdownColor: _kAccentColor,
              style: const TextStyle(color: _kPrimaryColor, fontSize: 18),
              items: filters.map((filter) => DropdownMenuItem(
                value: filter,
                child: Text(filter),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedFilter = value;
                  });
                }
              },
            ),
          ),
          Container(width: 1, height: 36, color: Colors.grey[400]),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Buscar vivienda, municipio...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: _kPrimaryColor, size: 28),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final double cardWidth;
  final double cardHeight;

  const _PropertyCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: cardHeight * 0.5,
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: cardWidth,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: cardHeight * 0.5,
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _kPrimaryColor)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Row(
                        children: [
                          Text('más detalles', style: TextStyle(color: _kPrimaryColor, decoration: TextDecoration.underline)),
                          Icon(Icons.arrow_forward_ios, size: 18, color: _kPrimaryColor),
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

class _FooterWidget extends StatelessWidget {
  final bool compact;
  const _FooterWidget({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: compact ? 16 : 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Contacta con nosotros',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 10),
          _ContactItem(icon: Icons.phone, text: '+34 641 85 39 23'),
          SizedBox(height: 5),
          _ContactItem(icon: Icons.email, text: 'habitalink@gmail.com'),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}