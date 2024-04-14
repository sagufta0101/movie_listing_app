import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_listing_app/models/movie_models.dart';
import 'package:movie_listing_app/presentation/widgets/gere_chips.dart';
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
                    top: 40,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // Play button (use your own play button asset or icon)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.play_circle_filled,
                          size: 64, color: Colors.white.withOpacity(0.9)),
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
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.white54,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${movieModel.runtime} minutes',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                        const SizedBox(width: 16),
                        if (movieModel.rating?.average != null)
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.white54, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${movieModel.rating?.average} (IMDb)',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
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
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8.0, // gap between adjacent chips
                                runSpacing: 4.0, // gap between lines
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

                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const Text('Summary',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),

                    const SizedBox(height: 4),
                    ReadMoreText(movieModel.summary ?? "",
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        trimMode: TrimMode.Line,
                        trimLines: 6,
                        colorClickableText: Colors.white,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))
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
