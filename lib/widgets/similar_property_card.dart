import 'package:flutter/material.dart';
import 'package:di_habitalink/theme/colors.dart';

class SimilarPropertyCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final void Function(BuildContext)?
  onTap; // Callback que recibe el BuildContext

  const SimilarPropertyCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 80,
                height: 80,
                color: AppColors.primaryLight,
                child: imageUrl.isNotEmpty
                    ? Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      )
                    : Center(
                        child: Icon(
                          Icons.apartment,
                          size: 30,
                          color: AppColors.hintTextColor.withOpacity(0.7),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            // Texto + botón
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (onTap != null) {
                        onTap!(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Detalles de: $title')),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.brown,
                    ),
                    label: const Text(
                      'Más detalles',
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
