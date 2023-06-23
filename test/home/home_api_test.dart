import 'package:book_app/feature/home/service/home_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookService Tests', () {
    late HomeService bookService;

    setUp(() {
      bookService = HomeService();
    });

    test('HomePage Books API Test', () async {
      final bestseller = await bookService.fetchBestsellerBooks();
      final trend = await bookService.fetchTrendingBooks();

      expect(bestseller.isNotEmpty, true);
      expect(trend.isNotEmpty, true);

      for (final bestsellerBook in bestseller) {
        expect(bestsellerBook.title.isNotEmpty, true);
        expect(bestsellerBook.author.isNotEmpty, true);
        expect(bestsellerBook.thumbnailUrl.isNotEmpty, true);
        expect(bestsellerBook.description.isNotEmpty || bestsellerBook.description == "", true);
      }
      for (final trendingBook in trend) {
        expect(trendingBook.title.isNotEmpty, true);
        expect(trendingBook.author.isNotEmpty, true);
        expect(trendingBook.thumbnailUrl.isNotEmpty, true);
        expect(trendingBook.description.isNotEmpty || trendingBook.description == "", true);
      }
    });
  });
}
