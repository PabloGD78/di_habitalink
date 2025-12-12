import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/property_card.dart';
import '../widgets/footer_widget.dart';
import '../pages/property_detail_page.dart';
import '../pages/property_detail_page3.dart';
import '../pages/new_listing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName'); // null si no hay usuario
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todos los datos de usuario
    Navigator.pushReplacementNamed(context, '/login'); // Volver al login
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                  if (userName == null)
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
                        ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        Text(
                          'Hola, $userName',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'logout') _logout();
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'logout',
                              child: Text('Cerrar sesión'),
                            ),
                          ],
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.primary,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              color: AppColors.primary,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botón "Comprar"
                  InkWell(
                    onTap: () {
                      // Aquí podrías agregar navegación si quieres
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Comprar',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Botón "Anunciar"
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewListingPage(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Anunciar',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Botón "Notificaciones"
                  InkWell(
                    onTap: () {
                      // Aquí podrías agregar navegación si quieres
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Notificaciones',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Botón "Favoritos"
                  InkWell(
                    onTap: () {
                      // Aquí podrías agregar navegación si quieres
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Favoritos',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColors.kPadding),
              child: SizedBox(height: 60, child: const SearchBarWidget()),
            ),
            const SizedBox(height: 40),
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
            SizedBox(
              height: cardHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final totalCardsWidth = 2 * cardWidth + AppColors.kMargin;
                  final horizontalPadding = (screenWidth - totalCardsWidth) / 2;
                  final safePadding = horizontalPadding > AppColors.kPadding
                      ? horizontalPadding
                      : AppColors.kPadding;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: safePadding),
                      child: Row(
                        children: [
                          PropertyCard(
                            imageUrl: 'assets/italyca/ref_01360/1.png',
                            title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
                            price: '380.000€',
                            cardWidth: cardWidth,
                            cardHeight: cardHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PropertyDetailPage3(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: AppColors.kMargin),
                          PropertyCard(
                            imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
                            title: 'Casa o chalet Independiente en venta en Santa Cruz - Alfalfa Centro, Sevilla',
                            price: '3.400.000€',
                            cardWidth: cardWidth,
                            cardHeight: cardHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PropertyDetailPage(),
                                ),
                              );
                            },
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
