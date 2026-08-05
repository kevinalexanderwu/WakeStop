import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// A rounded-square gradient avatar showing either a remote profile
/// image or a single-character initial — used in the map search bar's
/// profile FAB and the settings screen's profile card.
class UserAvatarBadge extends StatelessWidget {
  const UserAvatarBadge({
    super.key,
    this.imageUrl,
    this.initials = '?',
    this.size = 44,
    this.onTap,
  });

  /// Optional remote avatar image URL. When provided, it is shown
  /// instead of [initials].
  final String? imageUrl;

  /// Fallback single-character (or short) initial shown when
  /// [imageUrl] is `null`.
  final String initials;

  /// Overall square size of the avatar.
  final double size;

  /// Optional tap handler, e.g. to open Settings.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final radius = size * 0.32;

    final avatar = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, const Color(0xFF60A5FA)],
        ),
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl == null
            ? Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: size * 0.42,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );

    if (onTap == null) return avatar;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: avatar,
    );
  }
}