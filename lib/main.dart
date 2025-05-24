import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'repositories/album_repository.dart';
import 'viewmodels/album_list_viewmodel.dart';
import 'viewmodels/album_detail_viewmodel.dart';
import 'bloc/album_list_bloc.dart';
import 'bloc/album_detail_bloc.dart';
import 'screens/album_list_screen.dart';
import 'screens/album_detail_screen.dart';

void main() {
  final repository = AlbumRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;
  MyApp({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
            create: (_) => AlbumListBloc(AlbumListViewModel(repository: repository))..add(FetchAlbums()),
            child: const AlbumListScreen(),
          ),
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final albumId = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return BlocProvider(
              create: (_) => AlbumDetailBloc(AlbumDetailViewModel(repository: repository))..add(FetchAlbumDetail(albumId)),
              child: AlbumDetailScreen(albumId: albumId),
            );
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Albums App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}