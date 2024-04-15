import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:movie_listing_app/models/movie_models.dart';
import 'package:movie_listing_app/presentation/widgets/gere_chips.dart';
import 'package:movie_listing_app/presentation/widgets/html_text_widget.dart';
import 'package:movie_listing_app/presentation/widgets/white_loading_indicator.dart';
import 'package:readmore/readmore.dart';

import '../../utils/date_formatter.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({Key? key, required this.movieModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String premiered = movieModel.premiered != null
        ? formatDateString(movieModel.premiered!)
        : "";
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top part with back button and image
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: movieModel.image?.original ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300, // Set an appropriate height
                    placeholder: (context, url) =>
                        const Center(child: WhiteLoadingIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: 20,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // Play button (use your own play button asset or icon)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.white70, Colors.white30],
                          ).createShader(bounds);
                        },
                        child: Icon(Icons.play_circle_rounded,
                            size: 64, color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                ],
              ),
              // Movie details section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieModel.name ?? "",
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (movieModel.runtime != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                color: Colors.white60,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${movieModel.runtime} minutes',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade300),
                              ),
                            ],
                          ),
                        const SizedBox(width: 16),
                        if (movieModel.rating?.average != null)
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.white60, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${movieModel.rating?.average} (IMDb)',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade300),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Divider(
                      color: Colors.grey.shade700,
                      thickness: 0.5,
                    ),
                    // Premiere and Genre
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Premiered',
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text(premiered,
                                  style: const TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        // const SizedBox(width: 32),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Genre',
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 14.0, // gap between adjacent chips
                                runSpacing: 14.0, // gap between lines
                                children: movieModel.genres!
                                    .map((genre) => GenreChip(genre: genre))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Divider(
                      color: Colors.grey.shade700,
                      thickness: 0.5,
                    ),
                    const Text('Summary',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),

                    const SizedBox(height: 4),
                    HtmlReadMore(
                      trimLines: 5,
                      htmlData: movieModel.summary ?? '',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
