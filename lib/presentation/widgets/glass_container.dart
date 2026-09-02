import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.opacity = 0.1,
    this.blur = 10.0,
    this.borderRadius = 15.0,
    this.borderColor = AppColors.glassBackground,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

