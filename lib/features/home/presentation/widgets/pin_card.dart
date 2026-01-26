import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/pin_entity.dart';

class PinCard extends StatelessWidget {
  final PinEntity pin;
  final VoidCallback onTap;

  const PinCard({
    super.key,
    required this.pin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate aspect ratio, default to 2:3 if invalid
    final aspectRatio = pin.width > 0 && pin.height > 0 
        ? pin.width / pin.height 
        : 2 / 3;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.gridMainAxisSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.imageBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.imageBorderRadius),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image with proper loading and error handling
                CachedNetworkImage(
                  imageUrl: pin.imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: (context, url) => Container(
                    color: pin.color != null 
                      ? _parseColor(pin.color!)
                      : Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryRed,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_not_supported,
                          color: AppTheme.textSecondary,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Image failed to load',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Gradient overlay for Pinterest-like effect
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      splashColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.05),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                            ],
                            stops: const [0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('#')) {
        return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
      }
      return Colors.grey[300]!;
    } catch (e) {
      return Colors.grey[300]!;
    }
  }
}
