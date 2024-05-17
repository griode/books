import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  final int numberOfPage;
  final int currentPage;
  const PageIndicator(
      {super.key, required this.numberOfPage, required this.currentPage});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.numberOfPage; i++)
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: widget.currentPage == i ? 8 * 3 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(widget.currentPage == i ? 1 : 0.2),
            ),
          )
      ],
    );
  }
}
