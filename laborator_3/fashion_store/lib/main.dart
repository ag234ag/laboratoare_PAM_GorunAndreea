import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/favorites/favorites_cubit.dart';
import 'data/asset_store_repository.dart';
import 'data/store_repository.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(GemStoreApp(repository: AssetStoreRepository()));
}

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key, required this.repository});

  final StoreRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StoreRepository>.value(
      value: repository,
      child: BlocProvider(
        create: (_) => FavoritesCubit(repository)..load(),
        child: MaterialApp(
          title: 'GemStore',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
