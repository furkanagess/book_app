import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<Book> favorites = []; // Favori kitapları depolamak için boş bir liste oluşturun.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          Book book = favorites[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('By ${book.author}'),
            leading: Image.network(favorites[index].thumbnailUrl),
          );
        },
      ),
    );
  }
}
