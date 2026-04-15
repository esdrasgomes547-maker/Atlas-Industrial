import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CatalogProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<ProductCategory> _categories = [];
  String _selectedCategory = 'all';
  String _searchQuery = '';

  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;
  List<ProductCategory> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  CatalogProvider() {
    _initializeCatalog();
  }

  void _initializeCatalog() {
    // Inicializar categorias
    _categories = [
      ProductCategory(
        id: 'valves',
        name: 'Válvulas',
        icon: '🚫',
        description: 'Válvulas de GLP e derivados',
      ),
      ProductCategory(
        id: 'connections',
        name: 'Conexões',
        icon: '🔗',
        description: 'Conexões e acoplamentos',
      ),
      ProductCategory(
        id: 'extensions',
        name: 'Extensões',
        icon: '📏',
        description: 'Tubos e extensões',
      ),
      ProductCategory(
        id: 'regulators',
        name: 'Reguladores',
        icon: '⚙️',
        description: 'Reguladores de pressão',
      ),
      ProductCategory(
        id: 'accessories',
        name: 'Acessórios',
        icon: '🛠️',
        description: 'Acessórios diversos',
      ),
    ];

    // Exemplo de produtos iniciais
    _allProducts = [
      Product(
        id: '001',
        name: 'Válvula de Segurança SV-100',
        category: 'valves',
        description: 'Válvula de segurança de alta precisão para sistemas GLP com pressão até 60 bar.',
        specifications: [
          'Pressão máxima: 60 bar',
          'Material: Latão niquelado',
          'Vazão: 100 kg/h',
          'Certificação: ISO 9001',
        ],
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Valvula+SV-100',
        ],
        material: 'Latão niquelado',
        pressure: '60 bar',
        temperature: '-20°C a +60°C',
        connection: 'NPT 3/4"',
        price: 250.00,
        inStock: true,
        tags: ['válvula', 'segurança', 'GLP', 'alta pressão'],
        manufacturer: 'Atlas Industrial',
      ),
      Product(
        id: '002',
        name: 'Conexão Rápida CQ-45',
        category: 'connections',
        description: 'Conexão rápida para tubulações de GLP com vedação garantida.',
        specifications: [
          'Diâmetro: 1/2"',
          'Material: Aço carbono galvanizado',
          'Vazão: 150 kg/h',
          'Vedação: O-ring nitrílico',
        ],
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Conexao+CQ-45',
        ],
        material: 'Aço carbono galvanizado',
        pressure: '40 bar',
        temperature: '-10°C a +50°C',
        connection: 'Rosca NPT',
        price: 85.50,
        inStock: true,
        tags: ['conexão', 'rápida', 'aço', 'vedação'],
        manufacturer: 'Atlas Industrial',
      ),
    ];

    _filteredProducts = _allProducts;
  }

  void setSelectedCategory(String categoryId) {
    _selectedCategory = categoryId;
    _applyFilters();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final matchesCategory =
          _selectedCategory == 'all' || product.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          product.tags.any((tag) =>
              tag.toLowerCase().contains(_searchQuery.toLowerCase()));

      return matchesCategory && matchesSearch;
    }).toList();

    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProduct(Product product) {
    _allProducts.add(product);
    _applyFilters();
  }

  void updateProduct(Product product) {
    final index = _allProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _allProducts[index] = product;
      _applyFilters();
    }
  }
}
