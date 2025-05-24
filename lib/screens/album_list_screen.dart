import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/album_list_bloc.dart';
import '../models/album.dart';
import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: BlocBuilder<AlbumListBloc, AlbumListState>(
        builder: (context, state) {
          if (state is AlbumListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumListLoaded) {
            final albums = state.albums;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: albums.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final album = albums[index]['album'] as Album;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      radius: 26,
                      child: Text(
                        album.title.isNotEmpty ? album.title[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    title: Text(
                      album.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "Album ID: ${album.id}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.indigo),
                    onTap: () {
                      GoRouter.of(context).push('/album/${album.id}');
                    },
                  ),
                );
              },
            );
          } else if (state is AlbumListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AlbumListBloc>().add(FetchAlbums());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}