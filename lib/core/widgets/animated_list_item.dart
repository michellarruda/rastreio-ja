// Rastreio Já — Widget: AnimatedListItem
library;

import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  const AnimatedListItem({
    required this.index,
    required this.child,
    super.key,
    this.delay = Duration.zero,
  });

  final int index;
  final Widget child;
  final Duration delay;

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    final stagger = Duration(
      milliseconds: (widget.index * 60).clamp(0, 360),
    );
    final totalDelay = stagger + widget.delay;

    Future.delayed(totalDelay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      );
}
