import 'package:books/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailBook extends StatefulWidget {
  final Book book;
  const DetailBook({super.key, required this.book});

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text("Book Detail"),
        actions: [
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cloud_upload_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(widget.book.image),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // book info
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildItem(
                            "Rating",
                            widget.book.rating,
                            Icons.star_border_rounded,
                          ),
                          const SizedBox(height: 8),
                          _buildItem(
                            "Duration",
                            widget.book.duration,
                            Icons.timer_outlined,
                          ),
                          const SizedBox(height: 8),
                          _buildItem(
                            "Emotions",
                            widget.book.emotion,
                            Icons.emoji_objects_outlined,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.book.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Book by ${widget.book.author}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Text(
              widget.book.introduction,
              style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(height: 2),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("I want to read"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildItem(String name, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
