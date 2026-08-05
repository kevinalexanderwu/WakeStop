import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakestop/data/providers/station_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wakestop/data/providers/recent_search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  String _query = "";
  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(stationsProvider);
    final recent = ref.watch(recentSearchProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search destination...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: stationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text('Error: $e'),
        ),
        data: (stations) {
          final filteredStations = stations.where((station) {
            return station.name
                .toLowerCase()
                .contains(_query.toLowerCase());
          }).toList();
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (recent.isNotEmpty) ...[
                const Text(
                  "Recent",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...recent.map(
                  (station) => ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(station.name),
                    subtitle: Text(station.line),
                    onTap: () {
                      context.pop(station);
                    },
                  ),
                ),

                const SizedBox(height: 24),
              ],
              const Text(
                "All Stations",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              ...filteredStations.map(
                (station) => ListTile(
                  leading: const Icon(Icons.train),
                  title: Text(station.name),
                  subtitle: Text(station.line),
                  onTap: () {
                    ref.read(recentSearchProvider.notifier).add(station);

                    context.pop(station);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}