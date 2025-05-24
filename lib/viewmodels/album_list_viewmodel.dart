import '../repositories/album_repository.dart';
import '../models/photo.dart';

class AlbumListViewModel {
  final AlbumRepository repository;

  AlbumListViewModel({required this.repository});

  Future<List<Map<String, dynamic>>> getAlbumsWithPhotos() async {
    final albums = await repository.fetchAlbums();
    final photos = await repository.fetchPhotos();

    // For each album, find its first photo for thumbnail
    return albums.map((album) {
      final photo = photos.firstWhere(
        (p) => p.albumId == album.id,
        orElse: () => Photo(
          albumId: album.id,
          id: 0,
          title: '',
          url: '',
          thumbnailUrl: '',
        ),
      );
      return {
        'album': album,
        'photo': photo,
      };
    }).toList();
  }
}