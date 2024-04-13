import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_listing_app/presentation/screens/movie_detail_page.dart';

import '../../bloc/movie_bloc.dart';
import '../widgets/gradient_line.dart';
import '../widgets/movie_card.dart';
import '../widgets/white_loading_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieFailure) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is! MovieSuccess) {
          return const Center(
            child: WhiteLoadingIndicator(),
          );
        }

        final movieList = state.movieModel;

        return Padding(
          padding: const EdgeInsetsDirectional.all(22),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find Movies, Tv series,\nand more..',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                const GradientLine(),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 20,
                        childAspectRatio: (1 / 1.5),
                      ),
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                      movieModel: movieList[index],
                                    )));
                          },
                          child: MovieCard(
                            imageUrl: movieList[index].image?.medium ?? "",
                            title: movieList[index].name ?? "",
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
