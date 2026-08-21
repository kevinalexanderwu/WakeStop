import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakestop/data/providers/recent_search_provider.dart';
import 'package:wakestop/data/providers/station_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  String _query = '';
  String _selectedMode = 'All';

  final List<String> _modes = const [
    'All',
    'MRT',
    'KRL',
    'LRT Jakarta',
    'LRT Jabodebek',
    'TransJakarta',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            final matchesQuery = station.name
                .toLowerCase()
                .contains(_query.toLowerCase());

            final matchesMode =
                _selectedMode == 'All' ||
                station.mode == _selectedMode;

            return matchesQuery && matchesMode;
          }).toList();

          return Column(
            children: [
              const SizedBox(height: 12),

              // Transport mode filters.
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _modes.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final mode = _modes[index];
                    final isSelected = mode == _selectedMode;

                    return ChoiceChip(
                      label: Text(mode),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedMode = mode;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  children: [
                    if (recent.isNotEmpty && _query.isEmpty) ...[
                      const Text(
                        'Recent',
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
                          subtitle: Text(
                            '${station.mode} • ${station.line}',
                          ),
                          onTap: () {
                            context.pop(station);
                          },
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],

                    Text(
                      _selectedMode == 'All'
                          ? 'All Stations'
                          : _selectedMode,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (filteredStations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Center(
                          child: Text(
                            'No destinations found',
                          ),
                        ),
                      )
                    else
                      ...filteredStations.map(
                        (station) => ListTile(
                          leading: Icon(
                            _getModeIcon(station.mode),
                          ),
                          title: Text(station.name),
                          subtitle: Text(
                            '${station.mode} • ${station.line}',
                          ),
                          onTap: () {
                            ref
                                .read(recentSearchProvider.notifier)
                                .add(station);

                            context.pop(station);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _getModeIcon(String mode) {
    switch (mode) {
      case 'MRT':
        return Icons.subway;
      case 'KRL':
        return Icons.train;
      case 'LRT Jakarta':
      case 'LRT Jabodebek':
        return Icons.tram;
      case 'TransJakarta':
        return Icons.directions_bus;
      default:
        return Icons.location_on_outlined;
    }
  }
}