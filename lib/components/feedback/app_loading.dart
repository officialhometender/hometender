// lib/components/feedback/app_loading.dart
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizing.dart';

/// Custom loading indicator with different sizes and styles
class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final LoadingStyle style;

  const AppLoadingIndicator({
    super.key,
    this.size = AppSizing.iconLarge,
    this.color,
    this.strokeWidth = 2.0,
    this.style = LoadingStyle.circular,
  });

  /// Small loading indicator
  const AppLoadingIndicator.small({
    super.key,
    this.color,
    this.style = LoadingStyle.circular,
  })  : size = AppSizing.iconSmall,
        strokeWidth = 1.5;

  /// Medium loading indicator
  const AppLoadingIndicator.medium({
    super.key,
    this.color,
    this.style = LoadingStyle.circular,
  })  : size = AppSizing.iconMedium,
        strokeWidth = 2.0;

  /// Large loading indicator
  const AppLoadingIndicator.large({
    super.key,
    this.color,
    this.style = LoadingStyle.circular,
  })  : size = AppSizing.iconXLarge,
        strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colors.primary;

    return switch (style) {
      LoadingStyle.circular => SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: effectiveColor,
            strokeWidth: strokeWidth,
          ),
        ),
      LoadingStyle.linear => SizedBox(
          width: size,
          height: strokeWidth * 2,
          child: LinearProgressIndicator(
            color: effectiveColor,
            backgroundColor: effectiveColor.withValues(alpha: 0.2),
          ),
        ),
      LoadingStyle.dots => _DotsLoadingIndicator(
          size: size,
          color: effectiveColor,
        ),
    };
  }
}

/// Full screen loading overlay
class AppLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final Color? backgroundColor;

  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ??
                context.colors.background.withValues(alpha: 0.8),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLoadingIndicator.large(),
                  if (message != null) ...[
                    const SizedBox(height: AppSizing.lg),
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: context.colors.onBackground,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Shimmer loading effect for list items
class AppShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const AppShimmer({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final colors = context.colors;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                colors.surfaceVariant,
                colors.surface,
                colors.surfaceVariant,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              transform: GradientRotation(_animation.value),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Dots loading animation
class _DotsLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const _DotsLoadingIndicator({
    required this.size,
    required this.color,
  });

  @override
  State<_DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<_DotsLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Stagger the animations
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 4;

    return SizedBox(
      width: widget.size,
      height: dotSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: 0.5 + (_animations[index].value * 0.5),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(
                      alpha: 0.3 + (_animations[index].value * 0.7),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Loading style options
enum LoadingStyle {
  circular,
  linear,
  dots,
}
