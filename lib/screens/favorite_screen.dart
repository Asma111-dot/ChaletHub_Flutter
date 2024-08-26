import 'package:chalet_2/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favoriteItems;

  FavoritesScreen({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Favorites',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteItems[index]),
          );
        },
      ),
    );
  }
}
