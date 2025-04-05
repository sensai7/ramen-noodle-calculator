import 'package:flutter/material.dart';

class ZoomableImage extends StatefulWidget {
  const ZoomableImage({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late TapDownDetails tapDownDetails;
  late AnimationController animationController;
  late Animation<Matrix4>? animation;

  @override
  initState() {
    super.initState();
    controller = TransformationController();
    tapDownDetails = TapDownDetails();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        controller.value = animation!.value;
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) => tapDownDetails = details,
        onTap: () {
          final position = tapDownDetails.localPosition;
          const double scale = 2;
          final x = -position.dx * (scale - 1);
          final y = -position.dy * (scale - 1);
          final zoomed = Matrix4.identity()
            ..translate(x, y)
            ..scale(scale);
          final end = controller.value.isIdentity() ? zoomed : Matrix4.identity();
          animation = Matrix4Tween(
            begin: controller.value,
            end: end,
          ).animate(CurveTween(curve: Curves.easeOut).animate(animationController));

          animationController.forward(from: 0);
        },
        child: InteractiveViewer(
          //clipBehavior: Clip.none,
          panEnabled: false,
          scaleEnabled: false,
          transformationController: controller,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(widget.imageURL),
          ),
        ));
  }
}
