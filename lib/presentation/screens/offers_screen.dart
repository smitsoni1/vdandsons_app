import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/glass_container.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      appBar: AppBar(
        backgroundColor: AppColors.richBlack,
        elevation: 0,
        title: const Text(
          "Exclusive Offers",
          style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryGold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: const Text(
                "Festival Offers",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildOfferCard(
              title: "Diwali Special",
              description: "Flat 20% OFF on Making Charges of Gold Jewellery",
              validity: "Valid until 15th Nov",
              icon: Icons.celebration,
              index: 0,
            ),
            _buildOfferCard(
              title: "Wedding Season",
              description: "Buy Diamond worth ₹5L and get a Gold Coin FREE",
              validity: "Valid until 31st Dec",
              icon: Icons.card_giftcard,
              index: 1,
            ),
            const SizedBox(height: 30),
            FadeInDown(
              delay: const Duration(milliseconds: 300),
              child: const Text(
                "Discount Cards",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDiscountCard(
              name: "Gold Membership",
              discount: "5% Additional Discount",
              color: AppColors.primaryGold,
              index: 2,
            ),
            _buildDiscountCard(
              name: "Platinum Circle",
              discount: "10% Additional Discount",
              color: const Color(0xFFE5E4E2), // Platinum color
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String description,
    required String validity,
    required IconData icon,
    required int index,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: GlassContainer(
          borderColor: AppColors.primaryGold.withOpacity(0.5),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryGold, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      validity,
                      style: const TextStyle(color: AppColors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountCard({
    required String name,
    required String discount,
    required Color color,
    required int index,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), AppColors.surfaceBlack],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(Icons.stars, color: color.withOpacity(0.1), size: 150),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: color,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "VD & SONS JEWELLERS",
                        style: TextStyle(color: AppColors.white, fontSize: 10, letterSpacing: 2),
                      ),
                    ],
                  ),
                  Text(
                    discount,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
