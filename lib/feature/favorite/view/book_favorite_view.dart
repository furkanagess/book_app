import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<Book> _favorites = []; // Favori kitapları depolamak için boş bir liste oluşturun.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          Book book = _favorites[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('By ${book.author}'),
            leading: Image.network(_favorites[index].thumbnailUrl),
          );
        },
      ),
    );
  }
}
