import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A utility to render a specific slice (viewport) of a larger SVG file.
/// This acts like a sprite sheet renderer for UI skinning.
class SvgSprite extends StatelessWidget {
  final String assetName;
  final double sourceX;
  final double sourceY;
  final double sourceWidth;
  final double sourceHeight;
  final double width;
  final double height;

  const SvgSprite({
    super.key,
    required this.assetName,
    required this.sourceX,
    required this.sourceY,
    required this.sourceWidth,
    required this.sourceHeight,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          alignment: Alignment.topLeft,
          child: Transform.translate(
            offset: Offset(-sourceX, -sourceY),
            child: SizedBox(
              // Calculate how large the SVG needs to be rendered
              // so that the sliced part fits into width x height
              width: width * (1 / (sourceWidth / width)),
              height: height * (1 / (sourceHeight / height)),
              // Using a simple scaling for the sprite approach.
              // In a real app, you might parse the SVG to viewBoxes or use Canvas.
              child: SvgPicture.asset(
                assetName,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A skinned button wrapper using the SvgSprite
class SkinnedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const SkinnedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        // Here you would layer the SvgSprite as the background
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Dummy implementation of SvgSprite for preview purposes
            // const SvgSprite(
            //   assetName: 'assets/ui_skin.svg',
            //   sourceX: 0, sourceY: 0, sourceWidth: 150, sourceHeight: 50,
            //   width: 150, height: 50
            // ),
            Container(color: Colors.blueAccent.withOpacity(0.5)), // fallback
            child,
          ],
        ),
      ),
    );
  }
}
