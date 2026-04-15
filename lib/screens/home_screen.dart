import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../providers/catalog_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CatalogProvider catalogProvider;
  Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    catalogProvider = context.read<CatalogProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atlas Industrial',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: AppTheme.primaryDark,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.pushNamed('search');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Seção de Categorias
          _buildCategoriesSection(context),
          // Grid de Produtos
          Expanded(
            child: _buildProductsGrid(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Consumer<CatalogProvider>(
      builder: (context, catalogProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Chip "Todos"
                _buildCategoryChip(
                  context,
                  categoryId: 'all',
                  label: 'Todos',
                  icon: '📦',
                  isSelected: catalogProvider.selectedCategory == 'all',
                  onTap: () {
                    catalogProvider.setSelectedCategory('all');
                  },
                ),
                const SizedBox(width: 8),
                // Chips de categorias
                ...catalogProvider.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildCategoryChip(
                      context,
                      categoryId: category.id,
                      label: category.name,
                      icon: category.icon,
                      isSelected:
                          catalogProvider.selectedCategory == category.id,
                      onTap: () {
                        catalogProvider.setSelectedCategory(category.id);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(
    BuildContext context, {
    required String categoryId,
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryAccent
              : AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryAccent
                : AppTheme.borderColor,
          ),
        ),
        child: Row(
          children: [
            Text(icon),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppTheme.primaryDark
                    : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
    return Consumer<CatalogProvider>(
      builder: (context, catalogProvider, _) {
        final products = catalogProvider.filteredProducts;

        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhum produto encontrado',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              isFavorite: favorites.contains(product.id),
              onFavorite: () {
                setState(() {
                  if (favorites.contains(product.id)) {
                    favorites.remove(product.id);
                  } else {
                    favorites.add(product.id);
                  }
                });
              },
            );
          },
        );
      },
    );
  }
}
