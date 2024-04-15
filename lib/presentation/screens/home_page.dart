import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_listing_app/presentation/screens/movie_detail_page.dart';

import '../../bloc/movie_bloc.dart';
import '../../utils/date_formatter.dart';
import '../widgets/gradient_bottom_bar.dart';
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
  int _selectedIndex = 1;

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
      bottomNavigationBar: GradientBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
            child: SingleChildScrollView(
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
                  GridView.custom(
                      shrinkWrap: true,
                      gridDelegate: SliverWovenGridDelegate.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 12,
                        pattern: [
                          WovenGridTile(
                            5 / 7,
                            // crossAxisRatio: 0.9,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                          WovenGridTile(
                            5 / 6,
                          ),
                        ],
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      semanticChildCount: movieList.length,
                      childrenDelegate: SliverChildListDelegate(movieList
                          .map(
                            (movie) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                          movieModel: movie,
                                        )));
                              },
                              child: MovieCard(
                                imageUrl: movie.image?.medium ?? "",
                                title:
                                    "${movie.name} (${formatDateStringInYear(movie.premiered ?? '')})" ??
                                        "",
                              ),
                            ),
                          )
                          .toList())),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
