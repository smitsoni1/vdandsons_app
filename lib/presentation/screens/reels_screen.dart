import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/glass_container.dart';

class ReelsScreen extends StatelessWidget {
  final bool showBackButton;

  const ReelsScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Mock Video Content
              Image.network(
                'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?auto=format&fit=crop&q=80&w=800',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.richBlack.withOpacity(0.3), Colors.transparent, AppColors.richBlack.withOpacity(0.7)],
                  ),
                ),
              ),

              // UI Overlay
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "@vdandsons_jewellers",
                            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The Royal Collection - Handcrafted 22K Gold Necklace ✨ #LuxuryJewellery #VDandSons",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70), // Extra padding for BottomNav
                  ],
                ),
              ),

              // Right Side Actions
              Positioned(
                right: 15,
                bottom: 120,
                child: Column(
                  children: [
                    _buildActionButton(Icons.favorite, "1.2k"),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.comment, "45"),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.share, "Share"),
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryGold,
                      child: Icon(Icons.shopping_bag, color: AppColors.richBlack),
                    ),
                  ],
                ),
              ),

              // Close Button
              if (showBackButton)
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return FadeInRight(
      child: Column(
        children: [
          Icon(icon, color: AppColors.white, size: 35),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: AppColors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

