import 'dart:developer';

class MovieModel {
  int? id;
  String? name;
  List<String>? genres;
  int? runtime;
  String? premiered;
  Rating? rating;
  Image? image;
  String? summary;

  MovieModel({
    this.id,
    this.name,
    this.genres,
    this.runtime,
    this.premiered,
    this.rating,
    this.image,
    this.summary,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];

    genres = json['genres'].cast<String>();

    runtime = json['runtime'];

    premiered = json['premiered'];

    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;

    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['name'] = name;

    data['genres'] = genres;
    data['runtime'] = runtime;
    data['premiered'] = premiered;

    if (rating != null) {
      data['rating'] = rating!.toJson();
    }

    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;

    return data;
  }
}

class Rating {
  double? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    return data;
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}
