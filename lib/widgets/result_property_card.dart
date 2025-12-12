import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ResultPropertyCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String details;
  final double cardWidth;
  final double cardHeight;
  final VoidCallback? onDetailsPressed;

  final Color backgroundColor;
  final Color titleColor;
  final Color detailsColor;
  final Color priceColor;

  const ResultPropertyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.details,
    required this.cardWidth,
    required this.cardHeight,
    this.onDetailsPressed,
    this.backgroundColor = const Color(0xFFF0E5D0),
    this.titleColor = const Color(0xFF855227),
    this.detailsColor = AppColors.hintTextColor,
    this.priceColor = AppColors.primary,
  });

  @override
  State<ResultPropertyCard> createState() => _ResultPropertyCardState();
}

class _ResultPropertyCardState extends State<ResultPropertyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.cardWidth,
      height: widget.cardHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: widget.titleColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text('Precio: ${widget.price}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: widget.priceColor)),
                const SizedBox(height: 8),
                Text(widget.details, style: TextStyle(fontSize: 14, color: widget.detailsColor)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: widget.onDetailsPressed,
                      child: Text('Más detalles ↗', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10),
                    TextButton(onPressed: () {}, child: Text('Llamar', style: TextStyle(color: AppColors.primary))),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      child: const Text('Contactar', style: TextStyle(color: Colors.white)),
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
