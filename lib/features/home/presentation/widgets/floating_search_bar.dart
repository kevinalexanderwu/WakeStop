import 'package:flutter/material.dart';

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Material(
          elevation: 8,
          shadowColor: Colors.black.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      "Where are you going?",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .60,
                        ),
                      ),
                    ),
                  ),

                  Icon(
                    Icons.tune_rounded,
                    color: theme.colorScheme.onSurface.withValues(
                      alpha: .65,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}