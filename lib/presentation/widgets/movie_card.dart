import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_listing_app/presentation/widgets/white_loading_indicator.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const MovieCard({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(24)), // More rounded corners
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                      child: WhiteLoadingIndicator(),
                    ),
                errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    )),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
