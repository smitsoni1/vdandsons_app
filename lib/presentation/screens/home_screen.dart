import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../providers/product_provider.dart';
import '../widgets/premium_product_card.dart';
import '../widgets/glass_container.dart';
import 'product_details_screen.dart';
import 'catalog_screen.dart';
import 'offers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            FadeInDown(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&q=80&w=1000'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppColors.richBlack.withOpacity(0.8)],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "VD & SONS",
                          style: TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          "JEWELLERS",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Featured Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured Products",
                    style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CatalogScreen())),
                    child: const Text("View All", style: TextStyle(color: AppColors.primaryGold)),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 250,
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryGold));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.products.take(5).length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return FadeInRight(
                        delay: Duration(milliseconds: 100 * index),
                        child: Container(
                          width: 180,
                          margin: const EdgeInsets.all(5),
                          child: PremiumProductCard(
                            product: product,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsScreen(product: product),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Latest Reels Mockup
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Latest Reels",
                style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryGold, width: 1),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?auto=format&fit=crop&q=80&w=200'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.play_circle_outline, color: AppColors.white, size: 30),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Special Offers Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FadeInUp(
                child: GlassContainer(
                  borderColor: AppColors.primaryGold,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Festive Offer",
                              style: TextStyle(color: AppColors.primaryGold, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Up to 20% OFF on Gold Jewellery",
                              style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Valid until 31st Oct",
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OffersScreen()),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          foregroundColor: AppColors.richBlack,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("Claim Now"),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Shop Information Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: FadeInUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shop Information",
                      style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    GlassContainer(
                      borderColor: AppColors.primaryGold.withOpacity(0.3),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.store, color: AppColors.primaryGold),
                              SizedBox(width: 15),
                              Text(
                                "VD & Sons Jewellers",
                                style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(Icons.phone, color: AppColors.primaryGold),
                              SizedBox(width: 15),
                              Text(
                                "+91 98765 43210",
                                style: TextStyle(color: AppColors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(Icons.location_on, color: AppColors.primaryGold),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  "123, Luxury Plaza, Zaveri Bazaar, Mumbai",
                                  style: TextStyle(color: AppColors.white70, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _launchUrl('https://maps.google.com'),
                                  icon: const Icon(Icons.map, size: 18),
                                  label: const Text("Location"),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryGold,
                                    side: const BorderSide(color: AppColors.primaryGold),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _launchUrl('https://instagram.com'),
                                  icon: const Icon(Icons.camera_alt, size: 18),
                                  label: const Text("Instagram"),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryGold,
                                    side: const BorderSide(color: AppColors.primaryGold),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

