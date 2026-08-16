import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustamSvgWidget extends StatelessWidget {
  const CustamSvgWidget({
    super.key,
    required this.path,
    this.withColorFiter = true,
    this.height,
    this.width,
  });

  final String path;
  final bool withColorFiter;
  final double? width;
  final double? height;

  const CustamSvgWidget.WithoutColorFilter({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : withColorFiter = false;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: width,
      height: height,
      path,
      colorFilter: withColorFiter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
