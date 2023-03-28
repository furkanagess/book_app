import 'package:book_app/sample/changeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteBooks = Provider.of<FavoriteBooks>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: favoriteBooks.books.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                favoriteBooks.removeBook(book);
              },
            ),
          );
        },
      ),
    );
  }
}
