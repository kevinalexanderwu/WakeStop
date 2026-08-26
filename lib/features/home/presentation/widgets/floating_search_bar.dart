import 'package:flutter/material.dart';

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    super.key,
    required this.onTap,
    required this.onAccountTap,
  });

  final VoidCallback onTap;
  final VoidCallback onAccountTap;

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
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                // AREA SEARCH
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Where are you going?',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: .60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // TOMBOL ACCOUNT
                InkWell(
                  onTap: onAccountTap,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.surface,
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 28,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),

                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}