import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/result_property_card.dart';
import '../pages/property_detail_page.dart';
import '../pages/property_detail_page2.dart';
import '../pages/property_detail_page3.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double _kMaxWidth = 1200.0;
    final cardWidth = _kMaxWidth * 0.85;
    final cardHeight = 250.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 20),
                const Text(
                  "Mis Favoritos",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: _kMaxWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    ResultPropertyCard(
                      imageUrl: 'assets/italyca/ref_01360/1.png',
                      title:
                          'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                      details: '5 habs - 3 baños - 280 m2',
                      price: '380.000€',
                      cardWidth: cardWidth,
                      cardHeight: cardHeight,
                      onDetailsPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PropertyDetailPage3(),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Icon(
                        Icons.favorite,
                        color: const Color(0xFF007F3E), // Verde oscuro
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    ResultPropertyCard(
                      imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
                      title:
                          'Casa o chalet independiente en venta en Santa Cruz - Alfalfa',
                      details: '6 habs - 4 baños - 500 m2',
                      price: '3.400.000€',
                      cardWidth: cardWidth,
                      cardHeight: cardHeight,
                      onDetailsPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PropertyDetailPage(),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Icon(
                        Icons.favorite,
                        color: const Color(0xFF007F3E), // Verde oscuro
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
