// Barra de búsqueda con filtro desplegable.
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String selectedFilter = 'Vivienda';
  final List<String> filters = ['Vivienda', 'Obra Nueva', 'Oficina', 'Garaje', 'Localidad'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 26),
              dropdownColor: AppColors.accent,
              style: const TextStyle(color: AppColors.primary, fontSize: 18),
              items: filters.map((filter) => DropdownMenuItem(
                value: filter,
                child: Text(filter),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedFilter = value;
                  });
                }
              },
            ),
          ),
          Container(width: 1, height: 36, color: Colors.grey[400]),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Buscar vivienda, municipio...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.primary, size: 28),
          ),
        ],
      ),
    );
  }
}
