import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../providers/catalog_provider.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product? product;
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    product = context.read<CatalogProvider>().getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Produto não encontrado'),
          backgroundColor: AppTheme.primaryDark,
        ),
        body: const Center(
          child: Text('Produto não encontrado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Produto',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.primaryDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: AppTheme.primaryAccent,
            ),
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Galeria de Imagens
            _buildImageGallery(),
            // Informações do Produto
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome e categoria
                  _buildHeaderInfo(),
                  const SizedBox(height: 16),
                  // Status e preço
                  _buildPriceSection(),
                  const SizedBox(height: 24),
                  // Especificações
                  _buildSpecificationsSection(),
                  const SizedBox(height: 24),
                  // Descrição
                  _buildDescriptionSection(),
                  const SizedBox(height: 24),
                  // Botão de ação
                  _buildActionButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        // Imagem principal
        Container(
          width: double.infinity,
          height: 300,
          color: AppTheme.primaryDark,
          child: Image.network(
            product!.imageUrls.isNotEmpty
                ? product!.imageUrls[_currentImageIndex]
                : 'https://via.placeholder.com/400x300?text=${product!.name}',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Center(
              child: Icon(
                Icons.image_not_supported,
                color: AppTheme.primaryAccent,
                size: 64,
              ),
            ),
          ),
        ),
        // Miniaturas
        if (product!.imageUrls.length > 1)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: List.generate(
                  product!.imageUrls.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() => _currentImageIndex = index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _currentImageIndex == index
                              ? AppTheme.primaryAccent
                              : AppTheme.borderColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          product!.imageUrls[index],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppTheme.secondaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product!.name,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product!.category.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryAccent,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Fabricante: ${product!.manufacturer}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preço',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${product!.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryAccent,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: product!.inStock
                ? AppTheme.successColor
                : AppTheme.errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            product!.inStock ? '✓ Em Estoque' : '✕ Fora de Estoque',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Especificações Técnicas',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        _buildSpecItem('Material', product!.material),
        _buildSpecItem('Pressão', product!.pressure),
        _buildSpecItem('Temperatura', product!.temperature),
        _buildSpecItem('Conexão', product!.connection),
      ],
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product!.description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: AppTheme.textSecondary,
          ),
        ),
        if (product!.specifications.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Lista de Especificações',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          ...product!.specifications.map(
            (spec) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Text(
                    '• ',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryAccent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      spec,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: product!.inStock
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${product!.name} adicionado ao carrinho!',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryAccent,
          disabledBackgroundColor: AppTheme.textSecondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          product!.inStock ? 'Adicionar ao Carrinho' : 'Indisponível',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryDark,
          ),
        ),
      ),
    );
  }
}
