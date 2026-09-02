import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/providers/wishlist_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/catalog_screen.dart';
import 'presentation/screens/wishlist_screen.dart';
import 'presentation/screens/reels_screen.dart';
import 'presentation/screens/offers_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: const VDSonsApp(),
    ),
  );
}

class VDSonsApp extends StatelessWidget {
  const VDSonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VD & Sons Jewellers',
      theme: AppTheme.darkTheme,
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const ReelsScreen(),
    const WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OffersScreen()),
              ),
              backgroundColor: AppColors.primaryGold,
              child: const Icon(Icons.local_offer, color: AppColors.richBlack),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.primaryGold.withOpacity(0.3), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: AppColors.richBlack,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGold,
          unselectedItemColor: AppColors.grey.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), activeIcon: Icon(Icons.grid_view_rounded), label: "Catalog"),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), activeIcon: Icon(Icons.play_circle_fill), label: "Reels"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: "Wishlist"),
          ],
        ),
      ),
    );
  }
}

