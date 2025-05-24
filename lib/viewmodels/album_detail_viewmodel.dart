import '../repositories/album_repository.dart';
import '../models/photo.dart';

class AlbumDetailViewModel {
  final AlbumRepository repository;

  AlbumDetailViewModel({required this.repository});

  Future<List<Photo>> getPhotosForAlbum(int albumId) {
    return repository.fetchPhotosByAlbum(albumId);
  }
}