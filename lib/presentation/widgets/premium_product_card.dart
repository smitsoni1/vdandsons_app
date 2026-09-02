import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/product_model.dart';
import '../../core/constants/app_colors.dart';
import '../providers/wishlist_provider.dart';
import 'glass_container.dart';

class PremiumProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const PremiumProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderColor: AppColors.primaryGold,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.white10,
                        child: const Center(child: CircularProgressIndicator(color: AppColors.primaryGold)),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColors.primaryGold),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Consumer<WishlistProvider>(
                      builder: (context, wishlist, child) {
                        final isInWishlist = wishlist.isInWishlist(product.id);
                        return IconButton(
                          icon: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.primaryGold,
                          ),
                          onPressed: () => wishlist.toggleWishlist(product),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "₹${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                color: AppColors.primaryGold,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

