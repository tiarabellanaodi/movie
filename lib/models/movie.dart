class Movie {
  final String id;
  final String title;
  final String image;
  final double rating;
  final String genre;
  final String year;
  final bool isFavorite;
  final List<String> categories; // trending, popular, top_rated, dll
  final int order; // untuk sorting

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.genre,
    required this.year,
    this.isFavorite = false,
    this.categories = const [],
    this.order = 0,
  });

  factory Movie.fromFirestore(String id, Map<String, dynamic> data) {
    return Movie(
      id: id,
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      genre: data['genre'] ?? '',
      year: data['year'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      categories: List<String>.from(data['categories'] ?? []),
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'rating': rating,
      'genre': genre,
      'year': year,
      'isFavorite': isFavorite,
      'categories': categories,
      'order': order,
    };
  }

  Movie copyWith({
    String? id,
    String? title,
    String? image,
    double? rating,
    String? genre,
    String? year,
    bool? isFavorite,
    List<String>? categories,
    int? order,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      isFavorite: isFavorite ?? this.isFavorite,
      categories: categories ?? this.categories,
      order: order ?? this.order,
    );
  }
}