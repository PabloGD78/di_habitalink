// lib/widgets/result_property_card.dart

import 'package:flutter/material.dart';
import '../theme/colors.dart';

// ⭐ CLASE RENOMBRADA: Para evitar el conflicto con PropertyCard ⭐
class ResultPropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String details; // Lo que usas en el listado

  // ⭐ PARÁMETROS DE TAMAÑO AÑADIDOS (PARA COMPILAR CON EL ERROR) ⭐
  final double cardWidth;
  final double cardHeight;

  const ResultPropertyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.details,
    // AÑADIDOS PARA SATISFACER EL ERROR DE "MISSING REQUIRED ARGUMENT"
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Nota: Aunque los parámetros cardWidth y cardHeight están en el constructor
    // no los estamos usando aquí para que la tarjeta se expanda en la lista
    // de resultados. Usar estos valores aquí podría romper el diseño de listado.

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Imagen (Simulada para que se ajuste al listado)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Icon(Icons.apartment, size: 50, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),

          // 2. Detalles del Inmueble
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Precio: $price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                // MOSTRANDO EL CAMPO DETALLES
                Text(
                  details,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 12),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Llamar',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        'Contactar',
                        style: TextStyle(color: Colors.white),
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
