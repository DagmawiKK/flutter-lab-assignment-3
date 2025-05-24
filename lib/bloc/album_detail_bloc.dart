import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/album_detail_viewmodel.dart';
import '../models/photo.dart';

abstract class AlbumDetailEvent {}
class FetchAlbumDetail extends AlbumDetailEvent {
  final int albumId;
  FetchAlbumDetail(this.albumId);
}

abstract class AlbumDetailState {}
class AlbumDetailInitial extends AlbumDetailState {}
class AlbumDetailLoading extends AlbumDetailState {}
class AlbumDetailLoaded extends AlbumDetailState {
  final List<Photo> photos;
  AlbumDetailLoaded(this.photos);
}
class AlbumDetailError extends AlbumDetailState {
  final String message;
  AlbumDetailError(this.message);
}

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final AlbumDetailViewModel viewModel;
  AlbumDetailBloc(this.viewModel) : super(AlbumDetailInitial()) {
    on<FetchAlbumDetail>((event, emit) async {
      emit(AlbumDetailLoading());
      try {
        final photos = await viewModel.getPhotosForAlbum(event.albumId);
        emit(AlbumDetailLoaded(photos));
      } catch (e) {
        emit(AlbumDetailError(e.toString()));
      }
    });
  }
}