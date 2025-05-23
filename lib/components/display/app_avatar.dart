// lib/components/display/app_avatar.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Professional avatar component with different sizes and styles
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final VoidCallback? onTap;
  final AvatarStyle style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? badge;
  final bool showBorder;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = AppSizing.avatarMedium,
    this.onTap,
    this.style = AvatarStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.badge,
    this.showBorder = false,
  });

  /// Small avatar
  const AppAvatar.small({
    super.key,
    this.imageUrl,
    this.initials,
    this.onTap,
    this.style = AvatarStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.badge,
    this.showBorder = false,
  }) : size = AppSizing.avatarSmall;

  /// Medium avatar
  const AppAvatar.medium({
    super.key,
    this.imageUrl,
    this.initials,
    this.onTap,
    this.style = AvatarStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.badge,
    this.showBorder = false,
  }) : size = AppSizing.avatarMedium;

  /// Large avatar
  const AppAvatar.large({
    super.key,
    this.imageUrl,
    this.initials,
    this.onTap,
    this.style = AvatarStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.badge,
    this.showBorder = false,
  }) : size = AppSizing.avatarLarge;

  /// Extra large avatar
  const AppAvatar.extraLarge({
    super.key,
    this.imageUrl,
    this.initials,
    this.onTap,
    this.style = AvatarStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.badge,
    this.showBorder = false,
  }) : size = AppSizing.avatarXLarge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveBackgroundColor = backgroundColor ?? colors.primaryContainer;
    final effectiveForegroundColor =
        foregroundColor ?? colors.onPrimaryContainer;

    Widget avatar = _buildAvatar(
        context, effectiveBackgroundColor, effectiveForegroundColor);

    // Add border if requested
    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: style == AvatarStyle.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          border: Border.all(
            color: colors.outline,
            width: AppSizing.borderNormal,
          ),
          borderRadius: style == AvatarStyle.rounded
              ? BorderRadius.circular(AppSizing.radiusMedium)
              : null,
        ),
        child: avatar,
      );
    }

    // Add badge if provided
    if (badge != null) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            top: 0,
            child: badge!,
          ),
        ],
      );
    }

    // Add tap functionality if provided
    if (onTap != null) {
      avatar = GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildAvatar(
      BuildContext context, Color backgroundColor, Color foregroundColor) {
    final borderRadius = switch (style) {
      AvatarStyle.circle => null,
      AvatarStyle.rounded => BorderRadius.circular(AppSizing.radiusMedium),
      AvatarStyle.square => BorderRadius.circular(AppSizing.radiusSmall),
    };

    final shape =
        style == AvatarStyle.circle ? BoxShape.circle : BoxShape.rectangle;

    // If we have an image URL, try to load it
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: borderRadius,
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              // Fallback to initials on image load error
            },
          ),
        ),
        // Fallback content in case image fails to load
        child: imageUrl != null
            ? null
            : _buildInitialsContent(context, backgroundColor, foregroundColor),
      );
    }

    // Fallback to initials or default icon
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        borderRadius: borderRadius,
      ),
      child: _buildInitialsContent(context, backgroundColor, foregroundColor),
    );
  }

  Widget _buildInitialsContent(
      BuildContext context, Color backgroundColor, Color foregroundColor) {
    if (initials != null && initials!.isNotEmpty) {
      return Center(
        child: Text(
          initials!.toUpperCase(),
          style: TextStyle(
            color: foregroundColor,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Default person icon
    return Icon(
      Icons.person,
      color: foregroundColor,
      size: size * 0.6,
    );
  }
}

/// Avatar status badge
class AvatarBadge extends StatelessWidget {
  final AvatarBadgeStatus status;
  final double size;

  const AvatarBadge({
    super.key,
    required this.status,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final badgeColor = switch (status) {
      AvatarBadgeStatus.online => AppColors.success,
      AvatarBadgeStatus.offline => AppColors.gray400,
      AvatarBadgeStatus.busy => AppColors.error,
      AvatarBadgeStatus.away => AppColors.warning,
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.surface,
          width: 2,
        ),
      ),
    );
  }
}

/// Avatar group for showing multiple avatars
class AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final List<String?> initials;
  final double size;
  final int maxCount;
  final double overlap;
  final VoidCallback? onTap;

  const AvatarGroup({
    super.key,
    this.imageUrls = const [],
    this.initials = const [],
    this.size = AppSizing.avatarMedium,
    this.maxCount = 3,
    this.overlap = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = imageUrls.isNotEmpty ? imageUrls : initials;
    final displayItems = items.take(maxCount).toList();
    final remainingCount = items.length - maxCount;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size +
            (displayItems.length - 1) * (size - overlap) +
            (remainingCount > 0 ? size - overlap : 0),
        height: size,
        child: Stack(
          children: [
            // Display avatars
            ...displayItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return Positioned(
                left: index * (size - overlap),
                child: AppAvatar(
                  size: size,
                  imageUrl: imageUrls.isNotEmpty ? item : null,
                  initials: initials.isNotEmpty ? item : null,
                  showBorder: true,
                ),
              );
            }),

            // Show remaining count if there are more items
            if (remainingCount > 0)
              Positioned(
                left: displayItems.length * (size - overlap),
                child: AppAvatar(
                  size: size,
                  initials: '+$remainingCount',
                  backgroundColor: context.colors.surfaceVariant,
                  foregroundColor: context.colors.onSurfaceVariant,
                  showBorder: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Avatar style options
enum AvatarStyle {
  circle,
  rounded,
  square,
}

/// Avatar badge status options
enum AvatarBadgeStatus {
  online,
  offline,
  busy,
  away,
}
