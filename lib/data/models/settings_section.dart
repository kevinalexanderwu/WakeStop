import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// A single row within a [SettingsSection].
///
/// Pure data — mirrors the `SettingItem` shape from Section 7 — Data
/// Models — of the architecture analysis (label / value / toggle state)
/// as rendered by the source `SettingsScreen`. Interaction handling
/// (tap/toggle callbacks) is intentionally omitted from the model and
/// belongs to the presentation/application layer, which can dispatch on
/// [id].
@immutable
class SettingItem extends Equatable {
  const SettingItem({
    required this.id,
    required this.label,
    this.value,
    this.isToggle = false,
    this.toggled,
  });

  /// Stable identifier used by the application layer to route
  /// tap/toggle interactions back to this row (e.g. `'dark_mode'`,
  /// `'alert_distance'`).
  final String id;

  /// Row label, e.g. "Alert Distance", "Dark Mode".
  final String label;

  /// Display-only trailing value, e.g. "1 km before stop", "80%".
  /// Mutually exclusive with [isToggle] in practice.
  final String? value;

  /// Whether this row renders as a toggle switch rather than a
  /// value/chevron row.
  final bool isToggle;

  /// Current toggle state, when [isToggle] is `true`.
  final bool? toggled;

  SettingItem copyWith({
    String? id,
    String? label,
    String? value,
    bool? isToggle,
    bool? toggled,
  }) {
    return SettingItem(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isToggle: isToggle ?? this.isToggle,
      toggled: toggled ?? this.toggled,
    );
  }

  @override
  List<Object?> get props => [id, label, value, isToggle, toggled];

  @override
  bool get stringify => true;
}

/// A titled group of [SettingItem] rows.
///
/// Mirrors the `SettingsSection` shape from Section 7 — Data Models —
/// of the architecture analysis, corresponding to the "Alarm",
/// "Appearance", "Saved Places", and "About" groups in the source
/// `SettingsScreen`.
@immutable
class SettingsSection extends Equatable {
  const SettingsSection({
    required this.title,
    required this.items,
  });

  /// Section header, e.g. "Alarm", "Appearance".
  final String title;

  /// Ordered rows belonging to this section.
  final List<SettingItem> items;

  SettingsSection copyWith({
    String? title,
    List<SettingItem>? items,
  }) {
    return SettingsSection(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [title, items];

  @override
  bool get stringify => true;
}