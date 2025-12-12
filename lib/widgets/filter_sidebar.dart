// filter_sidebar.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/colors.dart';
import '../widgets/property_model.dart';

class FilterSidebar extends StatefulWidget {
  final Function(FilterData) onFilterChanged;

  const FilterSidebar({super.key, required this.onFilterChanged});

  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<FilterSidebar> {
  LatLng markerPosition = const LatLng(37.3886, -5.9823);

  RangeValues priceRange = const RangeValues(0, 4000000);
  String? selectedType;
  String? selectedBedrooms;
  String? selectedBathrooms;
  String? selectedFeature;

  void _applyFilters() {
    final filterData = FilterData(
      minPrice: priceRange.start.toInt(),
      maxPrice: priceRange.end.toInt(),
      type: selectedType,
      bedrooms: selectedBedrooms,
      bathrooms: selectedBathrooms,
      feature: selectedFeature,
    );
    widget.onFilterChanged(filterData);
  }

  void _clearFilters() {
    setState(() {
      priceRange = const RangeValues(0, 4000000);
      selectedType = null;
      selectedBedrooms = null;
      selectedBathrooms = null;
      selectedFeature = null;
      markerPosition = const LatLng(37.3886, -5.9823);
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mapa
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: 200,
              child: FlutterMap(
                options: MapOptions(
                  center: markerPosition,
                  zoom: 13,
                  onTap: (tapPosition, latlng) {
                    setState(() {
                      markerPosition = latlng;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: markerPosition,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Text('Rango de Precio', style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 4000000,
            divisions: 40,
            activeColor: AppColors.primary,
            labels: RangeLabels('€${(priceRange.start ~/ 1000)}k', '€${(priceRange.end ~/ 1000)}k'),
            onChanged: (values) {
              setState(() => priceRange = values);
              _applyFilters();
            },
          ),

          FilterDropdown(
            title: 'Tipo',
            options: const ['Casa', 'Piso', 'Chalet'],
            selectedOption: selectedType,
            onSelected: (value) {
              setState(() => selectedType = value);
              _applyFilters();
            },
          ),

          FilterDropdown(
            title: 'Habitaciones',
            options: const ['1', '2', '3', '4+'],
            selectedOption: selectedBedrooms,
            onSelected: (value) {
              setState(() => selectedBedrooms = value);
              _applyFilters();
            },
          ),

          FilterDropdown(
            title: 'Baños',
            options: const ['1', '2', '3+'],
            selectedOption: selectedBathrooms,
            onSelected: (value) {
              setState(() => selectedBathrooms = value);
              _applyFilters();
            },
          ),

          FilterDropdown(
            title: 'Características',
            options: const ['Piscina', 'Jardín', 'Garaje'],
            selectedOption: selectedFeature,
            onSelected: (value) {
              setState(() => selectedFeature = value);
              _applyFilters();
            },
          ),

          const SizedBox(height: 20),
          // Botón Aplicar Filtros con color de la paleta
          ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // color de la paleta
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Aplicar filtros', style: TextStyle(color: Colors.white)),
          ),
          // Botón Limpiar Filtros con color de la paleta
          TextButton(
            onPressed: _clearFilters,
            child: Text(
              'Limpiar filtros',
              style: TextStyle(color: AppColors.primary), // color de la paleta
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final Function(String?) onSelected;

  const FilterDropdown({
    super.key,
    required this.title,
    required this.options,
    this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final selected = selectedOption == option;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              onSelected: (_) => onSelected(selected ? null : option),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              labelStyle: TextStyle(color: selected ? Colors.white : AppColors.primary),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// Clase de filtros
class FilterData {
  final int minPrice;
  final int maxPrice;
  final String? type;
  final String? bedrooms;
  final String? bathrooms;
  final String? feature;

  FilterData({
    required this.minPrice,
    required this.maxPrice,
    this.type,
    this.bedrooms,
    this.bathrooms,
    this.feature,
  });
}
