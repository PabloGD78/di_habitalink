// lib/pages/search_results_page.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

// Importar los componentes y el tema
import '../theme/colors.dart';
import '../widgets/filter_sidebar.dart';
import '../widgets/result_property_card.dart';
import '../widgets/footer_widget.dart';
import '../widgets/search_bar_widget.dart';

const double _kMaxWidth = 1200.0;

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'HABITALINK',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
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

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: SizedBox(
                width: math.min(
                  _kMaxWidth * 0.7,
                  MediaQuery.of(context).size.width * 0.8,
                ),
                height: 48,
                child: SearchBarWidget(
                  accentColor: AppColors.accent.withOpacity(0.5),
                  primaryColor: AppColors.primary,
                  isDense: true,
                  borderRadius: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: SizedBox(
          width: _kMaxWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: FilterSidebar(),
                ),
              ),

              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const ResultPropertyCard(
                        imageUrl: 'assets/casa1.png',
                        title:
                            'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                        details: '5 habs - 3 baños - 280 m2',
                        price: '380.000€',
                        cardWidth: 600,
                        cardHeight: 250,
                      ),
                      const SizedBox(height: 20),

                      const ResultPropertyCard(
                        imageUrl: 'assets/casa2.png',
                        title:
                            'Casa o chalet independiente en venta en Santa Cruz - Alfalfa',
                        details: '6 habs - 4 baños - 500 m2',
                        price: '3.400.000€',
                        cardWidth: 600,
                        cardHeight: 250,
                      ),
                      const SizedBox(height: 20),

                      const ResultPropertyCard(
                        imageUrl: 'assets/casa3.png',
                        title:
                            'Piso en venta en Santa Cruz - Alfalfa Centro, Sevilla',
                        details: '2 habs - 1 baño - 85 m2',
                        price: '720.000€',
                        cardWidth: 600,
                        cardHeight: 250,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
