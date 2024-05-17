import 'dart:math';
import 'package:flutter/material.dart';

class TopicButton extends StatefulWidget {
  final String text;
  final Function(String topicName) onTap;
  final bool activate;
  const TopicButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.activate = false});

  @override
  State<TopicButton> createState() => _TopicButtonState();
}

class _TopicButtonState extends State<TopicButton> {
  final random = Random();
  bool _activate = false;

  @override
  Widget build(BuildContext context) {
    var color = getColor(context);

    return GestureDetector(
      onTap: () {
        widget.onTap(widget.text);
        setState(() {
          _activate = !_activate;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontWeight: _activate ? FontWeight.bold : FontWeight.normal,
              color: _activate
                  ? contrastingColor(color)
                  : Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
    );
  }

  Color getColor(BuildContext context) {
    return _activate
        ? Color.fromRGBO(
            random.nextInt(256), // Valeur de rouge
            random.nextInt(256), // Valeur de vert
            random.nextInt(256), // Valeur de bleu
            1.0, // Opacité (1.0 pour une couleur complètement opaque)
          )
        : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
  }

  Color contrastingColor(Color color) {
    // Calcul de la luminance
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    // Choix de la couleur de texte en fonction de la luminance
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
