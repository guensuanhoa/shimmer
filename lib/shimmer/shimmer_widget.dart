import 'package:flutter/material.dart';

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerWidget extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final Color? mainColor;
  final Color? slideColor;

  const ShimmerWidget({
    Key? key,
    required this.isLoading,
    required this.child,
    this.mainColor,
    this.slideColor,
  }) : super(key: key);

  @override
  _ShimmerWidgetState createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -1, max: 1, period: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_shimmerController)
      ..addListener(
        () {
          setState(() {});
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        var mainColor = widget.mainColor ?? Color(0xFFEBEBF4);
        return LinearGradient(
          stops: [0.1, 0.3, 0.4],
          colors: [
            mainColor,
            widget.slideColor ?? Color(0xFFF4F4F4),
            mainColor,
          ],
          begin: Alignment(-1.0, -0.2),
          end: Alignment(1.0, 0.2),
          transform: _SlidingGradientTransform(slidePercent: _animation.value),
        ).createShader(bounds);
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }
}
