import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../theme/colors.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class NewListingPage extends StatefulWidget {
  const NewListingPage({super.key});

  @override
  State<NewListingPage> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
  final _formKey = GlobalKey<FormState>();

  // Guardamos path + bytes + nombre
  List<Map<String, dynamic>> _images = [];

  bool _hasAttemptedSubmit = false;

  // *** Función para seleccionar imágenes ***
  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: true, // necesario para Web
    );

    if (result != null && result.files.isNotEmpty) {
      List<Map<String, dynamic>> pickedImages = [];

      for (var file in result.files) {
        // Para Web
        if (kIsWeb && file.bytes != null) {
          pickedImages.add({
            "bytes": file.bytes,
            "name": file.name,
          });
        }
        // Para móvil
        else if (!kIsWeb && file.path != null) {
          pickedImages.add({
            "path": file.path,
            "name": file.name,
          });
        }
      }

      // Si hay imágenes válidas, las agregamos al estado
      if (pickedImages.isNotEmpty) {
        setState(() {
          _images.addAll(pickedImages);
        });
      } else {
        print("No se seleccionaron imágenes válidas.");
      }
    } else {
      print("Selección cancelada.");
    }
  }

  // Construir widget de imagen para vista previa
  Widget _buildImageWidget(Map<String, dynamic> img) {
    if (kIsWeb && img["bytes"] != null) {
      return Image.memory(
        img["bytes"],
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && img["path"] != null) {
      return Image.file(
        File(img["path"]),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    return Container(
      width: 120,
      height: 120,
      color: Colors.grey.shade300,
      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
    );
  }

  // Widget para campos de texto
  Widget _buildTextField({
    required String label,
    String hint = '',
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio.';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.accent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  // Widget para subir imágenes y ver vista previa
  Widget _buildImageUploadArea() {
    final bool showImageError = _hasAttemptedSubmit && _images.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud_upload, size: 40, color: AppColors.primary),
                SizedBox(height: 8),
                Text(
                  'Haz clic para subir fotos (Drive, Archivos, Galería...)',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        if (showImageError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Debe añadir al menos una imagen.',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
        const SizedBox(height: 20),
        if (_images.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vista previa de las imágenes (${_images.length}):',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    final img = _images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildImageWidget(img),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _images.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const maxFormWidth = 700.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Crear Nuevo Anuncio',
          style: TextStyle(color: AppColors.lightTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.lightTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              width: screenWidth > maxFormWidth ? maxFormWidth : screenWidth * 0.95,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: AppColors.lightTextColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Detalles Principales de la Propiedad',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const Divider(color: AppColors.accent, thickness: 2, height: 40),
                  _buildTextField(
                    label: 'Título del Anuncio (máx 80 caracteres)',
                    hint: 'Ej: Apartamento moderno con vistas al mar',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Precio (€)',
                    hint: 'Ej: 250000',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Descripción Completa',
                    hint: 'Describe los mejores aspectos de tu propiedad...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '2. Características y Especificaciones',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const Divider(color: AppColors.accent, thickness: 2, height: 40),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(label: 'Dormitorios', keyboardType: TextInputType.number)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextField(label: 'Baños', keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(label: 'Superficie (m²)', keyboardType: TextInputType.number)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextField(label: 'Tipo de Propiedad', hint: 'Piso, Casa, Local...')),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '3. Fotos de la Propiedad',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const Divider(color: AppColors.accent, thickness: 2, height: 40),
                  _buildImageUploadArea(),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasAttemptedSubmit = true;
                        });

                        final formIsValid = _formKey.currentState!.validate();
                        final hasImages = _images.isNotEmpty;

                        if (formIsValid && hasImages) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Anuncio Publicado con ${_images.length} imágenes.'),
                              backgroundColor: AppColors.accent,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, rellena los campos y añade imágenes.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: const Text(
                        'Publicar Anuncio',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
