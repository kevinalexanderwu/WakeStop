import 'package:flutter/material.dart';

enum TransportType {
  all,
  mrt,
  krl,
  lrt,
  bus,
}

class TransportFilterChips extends StatelessWidget {
  const TransportFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final TransportType selected;
  final ValueChanged<TransportType> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 86,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: TransportType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _Chip(
                  type: type,
                  selected: selected == type,
                  onTap: () => onSelected(type),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final TransportType type;
  final bool selected;
  final VoidCallback onTap;

  String get label {
    switch (type) {
      case TransportType.all:
        return 'All';
      case TransportType.mrt:
        return 'MRT';
      case TransportType.krl:
        return 'KRL';
      case TransportType.lrt:
        return 'LRT';
      case TransportType.bus:
        return 'Bus';
    }
  }

  IconData get icon {
    switch (type) {
      case TransportType.all:
        return Icons.public;

      case TransportType.mrt:
        return Icons.subway;

      case TransportType.krl:
        return Icons.train;

      case TransportType.lrt:
        return Icons.tram;

      case TransportType.bus:
        return Icons.directions_bus;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: Material(
        color: selected
            ? scheme.primary
            : scheme.surface,
        borderRadius: BorderRadius.circular(24),
        elevation: selected ? 6 : 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected
                      ? Colors.white
                      : scheme.onSurface,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}