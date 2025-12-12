import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:di_habitalink/theme/colors.dart';
import 'package:di_habitalink/widgets/similar_property_card.dart';
import 'package:di_habitalink/widgets/search_bar_widget.dart';
import 'package:di_habitalink/pages/property_detail_page2.dart';
import 'package:di_habitalink/pages/property_detail_page3.dart'; // Importamos la segunda página
const propertyData = {
  'title':
      'Casa o chalet independiente en venta en Santa Cruz - Alfalfa Centro, Sevilla',
  'ref': 'REF: W-02UXX4',
  'price': '3.400.000€',
  'area': '888 m²',
  'beds': '10',
  'baths': '8',
  'description1':
      'Exclusiva y Majestuosa Casa Palacio en el corazón de Santa Cruz con gran Piscina. Esta casa se vende por 3.400.000€ (3.837€/m2) la propiedad única en el barrio de Santa Cruz más 300.000€ de las 4 plazas de garaje que están a 30 metros de la casa.',
  'description2':
      'Al entrar, desde las calles peatonales de la judería, a través de su imponente portón, se despliega un gran patio andaluz que invita a descubrir cada rincón de esta excepcional residencia. En la planta baja, se encuentran espaciosos despachos, dos amplios salones con chimeneas y comedores, que ofrecen el escenario perfecto para el entretenimiento de los huéspedes e invitados más exigentes.',
};

final LatLng propertyLocation = LatLng(37.3865, -5.9933);

final List<String> _images = [
  'assets/engels_volkers/ref_w02uxx4/1.png',
  'assets/engels_volkers/ref_w02uxx4/2.png',
  'assets/engels_volkers/ref_w02uxx4/3.png',
];

class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage({Key? key}) : super(key: key);

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
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
        child: _buildAppBar(),
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

  Widget _buildAppBar() {
    return Container(
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
                _buildDetailIcon('Piscina', Icons.pool),
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
            Text(
              propertyData['description2']!,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
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
                size: 20,
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
                size: 20,
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
          content: _buildSimilarPropertiesList(),
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
              options: MapOptions(center: propertyLocation, zoom: 16),
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
          'Barrio Santa Cruz - Alfalfa\nDistrito Centro\nSevilla\nSevilla capital, Sevilla',
          style: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSimilarPropertiesList() {
    return Column(
      children: [
        SimilarPropertyCard(
          title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
          price: '380.000€',
          imageUrl: 'assets/italyca/ref_01360/1.png',
          onTap: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PropertyDetailPage3(),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        SimilarPropertyCard(
          title: 'Piso en venta en Santa Cruz - Alfalfa Centro, Sevilla',
          price: '720.000€',
          imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
          onTap: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PropertyDetailPage2(),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// --------------------------------------
// Widget del título + favorito con estado
// --------------------------------------
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
