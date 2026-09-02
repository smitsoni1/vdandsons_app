import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/product_model.dart';
import '../../core/constants/app_colors.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/glass_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  void _launchWhatsApp(BuildContext context) async {
    final message = "Hello VD & Sons, I'm interested in the ${product.name} (Price: ₹${product.price}). Can I get more details?";
    final url = "https://wa.me/919876543210?text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 450,
            backgroundColor: AppColors.richBlack,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.white10),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColors.primaryGold),
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: AppColors.primaryGold),
          ),
          SliverToBoxAdapter(
            child: FadeInUp(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Text(
                          "₹${product.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.category,
                      style: const TextStyle(color: AppColors.primaryGold, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Description",
                      style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<WishlistProvider>(
                            builder: (context, wishlist, child) {
                              final isInWishlist = wishlist.isInWishlist(product.id);
                              return OutlinedButton.icon(
                                onPressed: () => wishlist.toggleWishlist(product),
                                icon: Icon(
                                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                                  color: AppColors.primaryGold,
                                ),
                                label: Text(
                                  isInWishlist ? "Saved to Wishlist" : "Add to Wishlist",
                                  style: const TextStyle(color: AppColors.primaryGold),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.primaryGold),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _launchWhatsApp(context),
                            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.richBlack),
                            label: const Text("WhatsApp Inquiry"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGold,
                              foregroundColor: AppColors.richBlack,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

