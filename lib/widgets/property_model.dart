class Property {
  final String id;
  final String imageUrl;
  final String title;
  final String details;
  final int price; // Precio en euros
  final int bedrooms; // Habitaciones
  final int bathrooms; // Baños
  final String type; // Ej: 'Piso', 'Casa', 'Chalet'
  final bool hasPool; // Característica
  final String detailPagePath; // Para navegación

  Property({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.details,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.type,
    required this.hasPool,
    required this.detailPagePath,
  });
}

// Datos de ejemplo
final List<Property> allProperties = [
  Property(
    id: '01360',
    imageUrl: 'assets/italyca/ref_01360/1.png',
    title: 'Casa Palacio en el corazón de Santa Cruz con gran Piscina',
    details: '5 habs - 3 baños - 280 m2',
    price: 380000,
    bedrooms: 5,
    bathrooms: 3,
    type: 'Casa',
    hasPool: true,
    detailPagePath: '/detail3',
  ),
  Property(
    id: 'w02uxx4',
    imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
    title: 'Casa o chalet independiente en venta en Santa Cruz - Alfalfa',
    details: '6 habs - 4 baños - 500 m2',
    price: 3400000,
    bedrooms: 6,
    bathrooms: 4,
    type: 'Chalet',
    hasPool: false,
    detailPagePath: '/detail1',
  ),
  Property(
    id: 'w02zvw0',
    imageUrl: 'assets/engels_volkers/ref_w02zvw0/1.png',
    title: 'Piso en venta en Santa Cruz - Alfalfa Centro, Sevilla',
    details: '2 habs - 1 baño - 85 m2',
    price: 720000,
    bedrooms: 2,
    bathrooms: 1,
    type: 'Piso',
    hasPool: false,
    detailPagePath: '/detail2',
  ),
  Property(
    id: '01361',
    imageUrl: 'assets/engels_volkers/ref_w02uxx4/1.png',
    title: 'Apartamento de Lujo con Terraza en el Centro',
    details: '3 habs - 2 baños - 120 m2',
    price: 950000,
    bedrooms: 3,
    bathrooms: 2,
    type: 'Piso',
    hasPool: false,
    detailPagePath: '/detail4',
  ),
  Property(
    id: '01362',
    imageUrl: 'assets/italyca/ref_01360/1.png',
    title: 'Villa con Jardín y Piscina cerca de la playa',
    details: '4 habs - 3 baños - 350 m2',
    price: 1800000,
    bedrooms: 4,
    bathrooms: 3,
    type: 'Casa',
    hasPool: true,
    detailPagePath: '/detail5',
  ),
];
