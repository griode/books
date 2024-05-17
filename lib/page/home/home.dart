import 'package:books/data/authors.dart';
import 'package:books/data/books.dart';
import 'package:books/model/book.dart';
import 'package:books/page/home/home_app_bar.dart';
import 'package:books/router/router_name.dart';
import 'package:books/widget/book_card.dart';
import 'package:books/widget/page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeAppBar(),
              _buildAuthorsSection(context),
              const SizedBox(height: 32),
              _buildBooksSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAuthorsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Authors of books",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailing: const Text("See all"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: authors
              .map((author) => _buildAuthorItem(context, author))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAuthorItem(BuildContext context, Map<String, String> author) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: CachedNetworkImageProvider(author["photo"] ?? ""),
          ),
          const SizedBox(height: 8),
          Text(
            author["name"] ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBooksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Books",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.1,
              child: CarouselSlider(
                items: books.map((book) => _buildBookCard(book)).toList(),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  height: double.infinity,
                  initialPage: 0,
                  viewportFraction: 0.6,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PageIndicator(
                numberOfPage: books.length,
                currentPage: currentIndex,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookCard(Book book) {
    int index = books.indexOf(book);
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.detailBook.name,
        extra: book,
      ),
      child: BookCard(
        isFirst: index == currentIndex - 1 ||
            (currentIndex == 0 && index == books.length - 1),
        isSecond: index == currentIndex + 1 ||
            (currentIndex == books.length - 1 && index == 0),
        isCurrent: index == currentIndex,
        book: book,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) => setState(() {
        pageIndex = value;
      }),
      currentIndex: pageIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.gite_outlined),
          label: '●',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark_outlined),
          label: '   ●   ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.headset_mic_outlined),
          label: '  ●  ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: ' ● ',
        ),
      ],
    );
  }
}
