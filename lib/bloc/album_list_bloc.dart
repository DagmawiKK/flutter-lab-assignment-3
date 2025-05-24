import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/album_list_viewmodel.dart';

abstract class AlbumListEvent {}
class FetchAlbums extends AlbumListEvent {}

abstract class AlbumListState {}
class AlbumListInitial extends AlbumListState {}
class AlbumListLoading extends AlbumListState {}
class AlbumListLoaded extends AlbumListState {
  final List<Map<String, dynamic>> albums;
  AlbumListLoaded(this.albums);
}
class AlbumListError extends AlbumListState {
  final String message;
  AlbumListError(this.message);
}

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumListViewModel viewModel;
  AlbumListBloc(this.viewModel) : super(AlbumListInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumListLoading());
      try {
        final albums = await viewModel.getAlbumsWithPhotos();
        emit(AlbumListLoaded(albums));
      } catch (e) {
        emit(AlbumListError(e.toString()));
      }
    });
  }
}