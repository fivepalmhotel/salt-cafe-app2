import 'package:flutter/material.dart';

class FavoriteFloatingButton extends StatelessWidget {
  const FavoriteFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 10,
      right: 15,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 25,
        child: Icon(Icons.favorite_border_sharp),
      ),
    );
  }
}
