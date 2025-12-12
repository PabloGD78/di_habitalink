import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/colors.dart';
import '../widgets/filter_sidebar.dart';
import '../widgets/result_property_card.dart';
import '../widgets/search_bar_widget.dart';
import '../pages/property_detail_page.dart';
import '../pages/property_detail_page2.dart';
import '../pages/property_detail_page3.dart';
import '../pages/notificaciones_page.dart';
import '../pages/favoritos_page.dart';
import '../widgets/property_model.dart';

const double _kMaxWidth = 1200.0;

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late List<Property> filteredProperties;

  @override
  void initState() {
    super.initState();
    filteredProperties = allProperties; // Inicialmente mostramos todas
  }

  void _onFilterChanged(FilterData filters) {
    setState(() {
      filteredProperties = allProperties.where((property) {
        if (property.price < filters.minPrice || property.price > filters.maxPrice) return false;
        if (filters.type != null && property.type != filters.type) return false;
        if (filters.bedrooms != null) {
          if (filters.bedrooms == '4+' && property.bedrooms < 4) return false;
          else if (filters.bedrooms != '4+' && property.bedrooms != int.tryParse(filters.bedrooms!)) return false;
        }
        if (filters.bathrooms != null) {
          if (filters.bathrooms == '3+' && property.bathrooms < 3) return false;
          else if (filters.bathrooms != '3+' && property.bathrooms != int.tryParse(filters.bathrooms!)) return false;
        }
        if (filters.feature != null) {
          if (filters.feature == 'Piscina' && !property.hasPool) return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = math.min(_kMaxWidth * 0.85, MediaQuery.of(context).size.width * 0.8);
    final cardHeight = 250.0;

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
                        icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritosPage()));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10.0)),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.person_outline, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ],
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
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: FilterSidebar(onFilterChanged: _onFilterChanged),
                ),
              ),
              Container(width: 2, color: AppColors.hintTextColor, margin: const EdgeInsets.symmetric(vertical: 20)),
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: filteredProperties.map((property) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ResultPropertyCard(
                          imageUrl: property.imageUrl,
                          title: property.title,
                          details: property.details,
                          price: '${property.price.toString()}€',
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          onDetailsPressed: () {
                            // Navegar según detailPagePath
                            Widget detailPage;
                            switch (property.detailPagePath) {
                              case '/detail1':
                                detailPage = const PropertyDetailPage();
                                break;
                              case '/detail2':
                                detailPage = const PropertyDetailPage2();
                                break;
                              case '/detail3':
                                detailPage = const PropertyDetailPage3();
                                break;
                              default:
                                detailPage = const PropertyDetailPage3();
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => detailPage));
                          },
                        ),
                      );
                    }).toList(),
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
