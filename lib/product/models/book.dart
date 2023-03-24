class Book {
  final String title;
  final String author;
  final String thumbnailUrl;
  final String description;

  Book({
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return Book(
      title: volumeInfo['title'],
      author: volumeInfo['authors']?.join(', ') ?? 'Unknown',
      thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'] ?? '',
      description: volumeInfo['description'] ?? '',
    );
  }
}
