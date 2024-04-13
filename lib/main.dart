import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/data_provider/movie_data_provider.dart';
import 'bloc/movie_bloc.dart';
import 'data/repository/movie_repository.dart';
import 'presentation/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(MovieDataProvider()),
      child: BlocProvider(
        create: (context) => MovieBloc(context.read<MovieRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
              scaffoldBackgroundColor: const Color(0xff15141F),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xff15141F))),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
