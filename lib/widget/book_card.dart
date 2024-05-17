import 'package:books/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final bool isFirst;
  final bool isCurrent;
  final bool isSecond;
  const BookCard(
      {super.key,
      this.isCurrent = false,
      this.isFirst = false,
      this.isSecond = false,
      required this.book});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(getAngle()),
      child: Container(
        margin: EdgeInsets.only(
          top: isCurrent ? 0 : 48,
          left: 16,
          right: 16,
          bottom: isCurrent ? 48 : 0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(book.image),
          ),
        ),
      ),
    );
  }

  double getAngle() {
    if (isFirst) {
      return -0.02;
    } else if (isSecond) {
      return 0.02;
    } else {
      return 0;
    }
  }
}
