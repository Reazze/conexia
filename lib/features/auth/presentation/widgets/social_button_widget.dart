import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color? borderColor;
  final Widget child;

  const SocialButtonWidget({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),

        width: double.infinity,
        height: 56,

        decoration: BoxDecoration(
          color: backgroundColor,

          borderRadius: BorderRadius.circular(30),

          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: 1.5,
                )
              : null,

          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6D28D9)
                  .withValues(alpha: 0.2),

              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: child,
      ),
    );
  }
}