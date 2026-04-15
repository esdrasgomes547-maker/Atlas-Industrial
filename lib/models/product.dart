class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> specifications;
  final List<String> imageUrls;
  final String material;
  final String pressure;
  final String temperature;
  final String connection;
  final double price;
  final bool inStock;
  final List<String> tags;
  final String manufacturer;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.specifications,
    required this.imageUrls,
    required this.material,
    required this.pressure,
    required this.temperature,
    required this.connection,
    required this.price,
    required this.inStock,
    required this.tags,
    required this.manufacturer,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      specifications: List<String>.from(json['specifications'] ?? []),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      material: json['material'] ?? '',
      pressure: json['pressure'] ?? '',
      temperature: json['temperature'] ?? '',
      connection: json['connection'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      inStock: json['inStock'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      manufacturer: json['manufacturer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'specifications': specifications,
      'imageUrls': imageUrls,
      'material': material,
      'pressure': pressure,
      'temperature': temperature,
      'connection': connection,
      'price': price,
      'inStock': inStock,
      'tags': tags,
      'manufacturer': manufacturer,
    };
  }
}

class ProductCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}
