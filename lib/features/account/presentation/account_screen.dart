import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    final isGuest = user?.isAnonymous ?? false;

    final displayName = isGuest
        ? 'Guest User'
        : user?.userMetadata?['full_name']?.toString() ??
            user?.email?.split('@').first ??
            'WakeStop User';

    final email = isGuest
        ? 'Using WakeStop as a guest'
        : user?.email ?? 'No email available';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // PROFILE
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    isGuest
                        ? Icons.person_outline_rounded
                        : Icons.person_rounded,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Account',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // TRIP HISTORY
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('Trip History'),
            subtitle: const Text('View your previous trips'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              context.push('/trip-history');
            },
          ),

          // SETTINGS
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            subtitle: const Text('Manage your preferences'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              context.push('/settings');
            },
          ),

          const SizedBox(height: 24),

          // SIGN OUT
          OutlinedButton.icon(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();

              if (context.mounted) {
                context.go('/auth');
              }
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}