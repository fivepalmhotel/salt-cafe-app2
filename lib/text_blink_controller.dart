import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  const BlinkingText({super.key});

  @override
  State<BlinkingText> createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Color> instagramColors = [
    Color(0xFF833AB4), // purple
    Color(0xFFF77737), // orange
    Color(0xFFE1306C), // red-pink
    Color(0xFFC13584), // dark pink
    Color(0xFFFD1D1D), // red
    Color(0xFF5851DB), // blue
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeats for the blinking effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: instagramColors,
              stops: List.generate(
                instagramColors.length,
                (i) => (_controller.value + i / instagramColors.length) % 1.0,
              ),
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },
          child: const Text(
            'Book a Table',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // will be overridden by ShaderMask
            ),
          ),
        );
      },
    );
  }
}
