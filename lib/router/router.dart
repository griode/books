import 'package:books/model/book.dart';
import 'package:books/page/detail_book.dart';
import 'package:books/page/home/home.dart';
import 'package:books/page/start.dart';
import 'package:books/router/router_name.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/start',
  routes: [
    GoRoute(
      path: '/start',
      name: RouteName.start.name,
      builder: (context, state) => const Start(),
    ),
    GoRoute(
      path: '/',
      name: RouteName.home.name,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/detail_book',
      name: RouteName.detailBook.name,
      builder: (context, state) => DetailBook(book: state.extra as Book),
    )
  ],
);
