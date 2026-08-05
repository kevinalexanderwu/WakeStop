import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// How the user authenticated into WakeStop.
///
/// Mirrors the Google / Apple / Continue-as-Guest options on the source
/// `AuthScreen` (see Section 7 — Data Models — `UserProfile`).
enum AuthProvider {
  google,
  apple,
  guest,
}

/// The signed-in (or guest) user's profile.
///
/// Mirrors the `UserProfile` shape from Section 7 — Data Models — of
/// the architecture analysis; corresponds to the hardcoded "Andi
/// Pratama" / avatar-initial data shown in the source `FloatingSearchBar`
/// and `SettingsScreen` components.
@immutable
class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.authProvider,
    this.email,
    this.avatarUrl,
    this.avatarInitial,
  });

  /// Stable unique identifier for the user.
  final String id;

  /// Display name, e.g. "Andi Pratama".
  final String displayName;

  /// Optional email address; typically absent for guest sessions.
  final String? email;

  /// Optional remote avatar image URL.
  final String? avatarUrl;

  /// Fallback single-character avatar initial, used when [avatarUrl] is
  /// unavailable (e.g. "A").
  final String? avatarInitial;

  /// The provider used to authenticate this session.
  final AuthProvider authProvider;

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? email,
    String? avatarUrl,
    String? avatarInitial,
    AuthProvider? authProvider,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarInitial: avatarInitial ?? this.avatarInitial,
      authProvider: authProvider ?? this.authProvider,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayName,
        email,
        avatarUrl,
        avatarInitial,
        authProvider,
      ];

  @override
  bool get stringify => true;
}