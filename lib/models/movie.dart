class Movie {
  final String id;
  final String title;
  final String image;
  final double rating;
  final String genre;
  final bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.genre,
    this.isFavorite = false,
  });

  factory Movie.fromFirestore(String id, Map<String, dynamic> data) {
    return Movie(
      id: id,
      title: data['title'],
      image: data['image'],
      rating: (data['rating'] as num).toDouble(),
      genre: data['genre'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'rating': rating,
      'genre': genre,
      'isFavorite': isFavorite,
    };
  }
}
