import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:di_habitalink/theme/colors.dart';
import 'package:di_habitalink/widgets/similar_property_card.dart';
import 'package:di_habitalink/widgets/search_bar_widget.dart';

import 'package:di_habitalink/pages/property_detail_page.dart';
import 'package:di_habitalink/pages/property_detail_page2.dart';

// Datos de la propiedad Calle San Vicente
const propertyData3 = {
  'title': 'Piso en venta en Calle San Vicente, 90',
  'ref': 'REF: SV-001',
  'price': '380.000 €',
  'area': '82 m²',
  'beds': '2',
  'baths': '1',
  'description1':
      'Descubre este espectacular piso reformado ubicado en una de las zonas más cotizadas del centro de Sevilla, San Lorenzo, e integrado en un edificio regionalista sevillano, ideal para quienes buscan comodidad y estilo, sin dejar atrás el gusto tradicional de nuestra ciudad.',
  'description2':
      'Con una superficie construida de 82 m², esta propiedad cuenta con un ambiente exterior muy luminoso gracias a sus tres balcones que dan a la calle. El inmueble dispone un gran salón comedor, dos dormitorios con armarios empotrados, así como un baño completo con una bonita y original reforma. La cocina, independiente, está completamente equipada. También incluye trastero, aire acondicionado central y techos altos que añaden amplitud al hogar.',
};

// Coordenadas aproximadas de Calle San Vicente
final LatLng propertyLocation3 = LatLng(37.3891, -5.9915);

// Lista de imágenes
final List<String> _images3 = [
  'assets/italyca/ref_01360/1.png',
  'assets/italyca/ref_01360/2.png',
  'assets/italyca/ref_01360/3.png',
];

class PropertyDetailPage3 extends StatefulWidget {
  const PropertyDetailPage3({Key? key}) : super(key: key);

  @override
  State<PropertyDetailPage3> createState() => _PropertyDetailPage3State();
}

class _PropertyDetailPage3State extends State<PropertyDetailPage3> {
  int _currentImageIndex = 0;

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images3.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _images3.length) % _images3.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.home, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pushNamed(context, '/'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: SearchBarWidget(
                      accentColor: AppColors.accent,
                      primaryColor: AppColors.primary,
                      isDense: true,
                      borderRadius: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth > 900;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildPropertyMainContent()),
        const SizedBox(width: 30),
        Expanded(flex: 1, child: _buildSidebar()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildPropertyMainContent(),
        const SizedBox(height: 30),
        _buildSidebar(),
      ],
    );
  }

  Widget _buildPropertyMainContent() {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            const SizedBox(height: 16),
            _FavoriteTitleRow(title: propertyData3['title']!),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildDetailIcon(propertyData3['area']!, Icons.crop_square),
                _buildDetailIcon('${propertyData3['beds']} hab', Icons.bed),
                _buildDetailIcon(
                  '${propertyData3['baths']} baño',
                  Icons.bathtub,
                ),
                _buildDetailIcon('Balcón', Icons.balcony),
                _buildDetailIcon('Trastero', Icons.storage),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              propertyData3['description1']!,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              propertyData3['description2']!,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      propertyData3['price']!,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      propertyData3['ref']!,
                      style: TextStyle(
                        color: AppColors.hintTextColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildActionButton(Icons.phone, 'Llamar'),
                    const SizedBox(width: 8),
                    _buildActionButton(Icons.email, 'Contactar'),
                    const SizedBox(width: 8),
                    _buildActionButton(Icons.share, 'Compartir'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              _images3[_currentImageIndex],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _previousImage,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _nextImage,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailIcon(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.hintTextColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: Colors.brown),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.brown,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebarSection(
          title: 'Ubicación',
          content: _buildLocationWithFlutterMap(),
        ),
        const SizedBox(height: 30),
        _buildSidebarSection(
          title: 'Descubre casas similares',
          content: _buildSimilarPropertiesList(context),
        ),
      ],
    );
  }

  Widget _buildSidebarSection({
    required String title,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.hintTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

  Widget _buildLocationWithFlutterMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 200,
            child: FlutterMap(
              options: MapOptions(center: propertyLocation3, zoom: 16),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40,
                      height: 40,
                      point: propertyLocation3,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Calle San Vicente, 90\nBarrio San Vicente\nDistrito Centro\nSevilla\nSevilla capital, Sevilla',
          style: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSimilarPropertiesList(BuildContext context) {
    return Column(
      children: [
        SimilarPropertyCard(
          title: 'Casa o chalet independiente en venta en Santa Cruz - Alfalfa',
          price: '3.400.000€',
          imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
          onTap: (_) {
            // puedes ignorar el parámetro si no lo necesitas
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PropertyDetailPage()),
            );
          },
        ),
        const SizedBox(height: 15),
        SimilarPropertyCard(
          title: 'Piso en venta en Santa Cruz - Alfalfa Centro, Sevilla',
          price: '720.000€',
          imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
          onTap: (_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PropertyDetailPage2()),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// ----------------------------
// Widget Título + Favorito
// ----------------------------
class _FavoriteTitleRow extends StatefulWidget {
  final String title;
  const _FavoriteTitleRow({required this.title});

  @override
  State<_FavoriteTitleRow> createState() => _FavoriteTitleRowState();
}

class _FavoriteTitleRowState extends State<_FavoriteTitleRow> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: const TextStyle(
              color: AppColors.hintTextColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: isFavorited ? Colors.white : AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? AppColors.primary : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
          ),
        ),
      ],
    );
  }
}
