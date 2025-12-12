import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:di_habitalink/theme/colors.dart';
import 'package:di_habitalink/widgets/similar_property_card.dart';
import 'package:di_habitalink/widgets/search_bar_widget.dart';

// IMPORTANTE → Importa la página 1 aquí
import 'package:di_habitalink/pages/property_detail_page.dart';
import 'package:di_habitalink/pages/property_detail_page3.dart';

// Datos de ejemplo para esta propiedad
const propertyData = {
  'title': 'Piso en venta en Santa Cruz - Alfalfa Centro, Sevilla',
  'ref': 'REF: W-02ZVW0',
  'price': '720.000€',
  'area': '172 m²',
  'beds': '5',
  'baths': '2',
  'description1':
      'Oportunidad: piso para reformar en Santa Cruz con plaza de aparcamiento. En pleno corazón del casco histórico de Sevilla, en el emblemático Barrio de Santa Cruz...',
  'description2':
      'La vivienda se organiza a partir de un hall de entrada que da paso a una distribución en forma de L, todas las estancias son exteriores y reciben abundante luz natural. Incluye plaza de aparcamiento y múltiples ventajas de ubicación y privacidad.',
};

// Coordenadas exactas de la ubicación
final LatLng propertyLocation = LatLng(37.388109106878666, -5.989567081778515);

// Lista de imágenes para el carrusel
final List<String> _images = [
  'assets/engels_volkers/ref_w02zvw0/1.png',
  'assets/engels_volkers/ref_w02zvw0/2.png',
  'assets/engels_volkers/ref_w02zvw0/3.png',
];

class PropertyDetailPage2 extends StatefulWidget {
  const PropertyDetailPage2({Key? key}) : super(key: key);

  @override
  State<PropertyDetailPage2> createState() => _PropertyDetailPage2State();
}

class _PropertyDetailPage2State extends State<PropertyDetailPage2> {
  int _currentImageIndex = 0;

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _images.length) % _images.length;
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
                const SizedBox(width: 15),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
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
            _FavoriteTitleRow(title: propertyData['title']!),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildDetailIcon(propertyData['area']!, Icons.crop_square),
                _buildDetailIcon('${propertyData['beds']} hab', Icons.bed),
                _buildDetailIcon(
                  '${propertyData['baths']} baños',
                  Icons.bathtub,
                ),
                _buildDetailIcon('Balcón', Icons.balcony),
                _buildDetailIcon('Garaje', Icons.directions_car),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              propertyData['description1']!,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.hintTextColor.withOpacity(0.7),
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              propertyData['description2']!,
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
                      propertyData['price']!,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      propertyData['ref']!,
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
              _images[_currentImageIndex],
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
          content: buildSimilarPropertiesList(context),
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
              options: MapOptions(center: propertyLocation, zoom: 18),
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
                      point: propertyLocation,
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
          'Calle Federico Rubio, 1 -4\nBarrio Santa Cruz - Alfalfa\nDistrito Centro\nSevilla\nSevilla capital, Sevilla',
          style: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
        ),
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

// ----------------------------
// Lista de propiedades similares
// ----------------------------
Widget buildSimilarPropertiesList(BuildContext context) {
  return Column(
    children: [
      // Casa de 380.000€ → abrirá PropertyDetailPage3
      SimilarPropertyCard(
        title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
        price: '380.000€',
        imageUrl: 'assets/italyca/ref_01360/1.png',
        onTap: (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PropertyDetailPage3(), // Página 3
            ),
          );
        },
      ),
      const SizedBox(height: 15),

      // Otra propiedad → abrirá PropertyDetailPage (la página 1)
      SimilarPropertyCard(
        title: 'Casa o chalet independiente en venta en Santa Cruz - Alfalfa',
        price: '3.400.000€',
        imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
        onTap: (_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PropertyDetailPage()),
          );
        },
      ),
      const SizedBox(height: 15),

      // Otra propiedad → abrirá PropertyDetailPage2
      const SizedBox(height: 15),
    ],
  );
}
