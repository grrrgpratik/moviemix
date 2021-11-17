import 'package:flutter/material.dart';
import 'package:moviemix/common/extension/size_extension.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({
    Key? key,
    required this.height,
  })  : assert(height > 0, 'height should be greater than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/png/logo.png',
      // color: Colors.white,
      height: height.h,
    );
  }
}
