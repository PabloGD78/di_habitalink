import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/colors.dart';
import '../widgets/nav_menu_item.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/property_card.dart';
import '../widgets/footer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Mantener ancho original de tarjetas
    final cardWidth = math.min(300.0, screenWidth * 0.25);
    final cardHeight = cardWidth * 1.5;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding, vertical: 8),
              child: Row(
                children: [
                  const Spacer(),
                  Center(
                    child: Image.asset(
                      'assets/logo/LogoSinFondo.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto centrado
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding),
                child: const Text(
                  'Conecta con tu espacio ideal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // SearchBar alineada a la izquierda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding),
            child: SizedBox(height: 60, child: const SearchBarWidget()),
            ),
            const SizedBox(height: 40),

            // Sección de exploración alineada a la izquierda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding),
              child: const Text(
                'Explora nuevas posibilidades',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding),
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
                  final totalCardsWidth = 2 * cardWidth + AppColors.kMargin;
                  final horizontalPadding = (screenWidth - totalCardsWidth) / 2;
                  final safePadding = horizontalPadding > AppColors.kPadding ? horizontalPadding : AppColors.kPadding;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: safePadding),
                      child: Row(
                        children: [
                          PropertyCard(
                            imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
                            title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                            price: '380.000€',
                            cardWidth: cardWidth,
                            cardHeight: cardHeight,
                          ),
                          const SizedBox(width: AppColors.kMargin),
                          PropertyCard(
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
      bottomNavigationBar: const FooterWidget(compact: true),
    );
  }
}


