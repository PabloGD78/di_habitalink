import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/colors.dart'; // Ajusta según tu proyecto

class FilterSidebar extends StatefulWidget {
  const FilterSidebar({super.key});

  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<FilterSidebar> {
  // Inicial Sevilla
  LatLng markerPosition = LatLng(37.3886, -5.9823);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mapa interactivo
          SizedBox(
            height: 200,
            child: FlutterMap(
              options: MapOptions(
                center: markerPosition,
                zoom: 13,
                // Cuando el usuario toque el mapa, actualizamos el marcador
                onTap: (tapPosition, latlng) {
                  setState(() {
                    markerPosition = latlng;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: markerPosition,
                      width: 40,
                      height: 40,
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
          const SizedBox(height: 20),

          // Filtros funcionales
          FilterDropdown(
            title: 'Rango de Precio',
            options: ['0-100k', '100k-300k', '300k+'],
          ),
          const SizedBox(height: 10),
          FilterDropdown(
            title: 'Tipo',
            options: ['Vivienda', 'Oficina', 'Local'],
          ),
          const SizedBox(height: 10),
          FilterDropdown(title: 'Habitaciones', options: ['1', '2', '3', '4+']),
          const SizedBox(height: 10),
          FilterDropdown(title: 'Baños', options: ['1', '2', '3+']),
          const SizedBox(height: 10),
          FilterDropdown(
            title: 'Características',
            options: ['Piscina', 'Jardín', 'Garaje'],
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Dropdown funcional
// -----------------------------
class FilterDropdown extends StatefulWidget {
  final String title;
  final List<String> options;

  const FilterDropdown({
    required this.title,
    this.options = const ['Opción 1', 'Opción 2', 'Opción 3'],
    super.key,
  });

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2F544D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: primaryColor,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: widget.options
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}
