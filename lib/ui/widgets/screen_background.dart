import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../util/asset_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              AssetPath.backgroundSvg,
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
            ),
            SafeArea(child: child),
          ],
        )
    );
  }
}
