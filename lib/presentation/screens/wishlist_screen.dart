import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../providers/wishlist_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/premium_product_card.dart';
import 'product_details_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      appBar: AppBar(
        backgroundColor: AppColors.richBlack,
        elevation: 0,
        title: const Text("My Wishlist", style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.primaryGold),
      ),
      body: Consumer2<WishlistProvider, ProductProvider>(
        builder: (context, wishlist, productProvider, child) {
          final wishlistProducts = productProvider.products
              .where((p) => wishlist.isInWishlist(p.id))
              .toList();

          if (wishlistProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, color: Colors.white24, size: 80),
                  const SizedBox(height: 20),
                  const Text("Your wishlist is empty", style: TextStyle(color: Colors.white54, fontSize: 18)),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Go Shopping", style: TextStyle(color: AppColors.primaryGold)),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemCount: wishlistProducts.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 50 * index),
                child: PremiumProductCard(
                  product: wishlistProducts[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: wishlistProducts[index]),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

