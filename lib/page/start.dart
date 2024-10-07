import 'package:books/data/topic.dart';
import 'package:books/router/router_name.dart';
import 'package:books/widget/page_indicator.dart';
import 'package:books/widget/topic_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentPage = 0;
  final _topicsChooses = [];
  final firstPageKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PageIndicator(
                        numberOfPage: 3,
                        currentPage: _currentPage,
                      )
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    "Choose your goals",
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (value) => setState(() {
                  _currentPage = value;
                }),
                children: [
                  // cinema
                  SingleChildScrollView(
                    child: Wrap(
                      key: firstPageKey,
                      spacing: 12,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: topics["cinema"]!
                          .map((e) => TopicButton(
                                text: e,
                                activate: _topicsChooses.contains(e),
                                onTap: _nextHome,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _nextHome(String topic) {
    // Topic action
    if (_topicsChooses.contains(topic)) {
      _topicsChooses.remove(topic);
    } else {
      _topicsChooses.add(topic);
    }
    if (_topicsChooses.length == 8) {
      context.goNamed(RouteName.home.name);
    }
  }
}
