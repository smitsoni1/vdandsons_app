import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../providers/product_provider.dart';
import '../widgets/premium_product_card.dart';
import '../widgets/category_chip.dart';
import 'product_details_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  final List<String> categories = ['All', 'Rings', 'Necklaces', 'Earrings', 'Bracelets', 'Bangles'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      appBar: AppBar(
        backgroundColor: AppColors.richBlack,
        elevation: 0,
        title: const Text("Catalog", style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.primaryGold),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "Search luxury items...",
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryGold),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.05),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.primaryGold, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.primaryGold, width: 1.5),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
            ),
          ),

          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryChip(
                  label: categories[index],
                  isSelected: selectedCategory == categories[index],
                  onTap: () => setState(() => selectedCategory = categories[index]),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          // Products Grid
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryGold));
                }

                final filteredProducts = provider.products.where((p) {
                  final matchesCategory = selectedCategory == 'All' || p.category == selectedCategory;
                  final matchesSearch = p.name.toLowerCase().contains(searchQuery);
                  return matchesCategory && matchesSearch;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text("No products found", style: TextStyle(color: Colors.white54)),
                  );
                }

                return MasonryGridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      delay: Duration(milliseconds: 50 * index),
                      child: PremiumProductCard(
                        product: filteredProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: filteredProducts[index]),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

