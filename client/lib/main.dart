import 'package:client/core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const FeaturedAlbumsScreen(),
    );
  }
}

/// Simple data model that mirrors what an API response might look like.
class Album {
  const Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.artworkUrl,
  });

  final int id;
  final String title;
  final String artist;
  final String artworkUrl;
}

/// Mock API class. Replace this with your real HTTP client later.
class MockAlbumApi {
  static Future<List<Album>> fetchFeaturedAlbums() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return const [
      Album(
        id: 1,
        title: 'Midnight Groove',
        artist: 'Luna Waves',
        artworkUrl: 'https://picsum.photos/seed/groove/600/400',
      ),
      Album(
        id: 2,
        title: 'Sunset Drive',
        artist: 'Neon Skyline',
        artworkUrl: 'https://picsum.photos/seed/sunset/600/400',
      ),
      Album(
        id: 3,
        title: 'Rainy City Jazz',
        artist: 'Blue Umbrella',
        artworkUrl: 'https://picsum.photos/seed/jazz/600/400',
      ),
      Album(
        id: 4,
        title: 'Desert Bloom',
        artist: 'Amber Trails',
        artworkUrl: 'https://picsum.photos/seed/desert/600/400',
      ),
    ];
  }
}

class FeaturedAlbumsScreen extends StatefulWidget {
  const FeaturedAlbumsScreen({super.key});

  @override
  State<FeaturedAlbumsScreen> createState() => _FeaturedAlbumsScreenState();
}

class _FeaturedAlbumsScreenState extends State<FeaturedAlbumsScreen> {
  late final Future<List<Album>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    _albumsFuture = MockAlbumApi.fetchFeaturedAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Albums'),
      ),
      body: FutureBuilder<List<Album>>(
        future: _albumsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            );
          }
          final albums = snapshot.data ?? const <Album>[];
          if (albums.isEmpty) {
            return const Center(child: Text('No albums found.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return _AlbumCard(album: album);
                },
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: albums.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  const _AlbumCard({required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                album.artworkUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: theme.colorScheme.surfaceVariant,
                  alignment: Alignment.center,
                  child: const Icon(Icons.music_note, size: 42),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(album.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    album.artist,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
