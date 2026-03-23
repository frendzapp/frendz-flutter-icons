import 'package:flutter/widgets.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Icon extends StatelessWidget {
  final String asset;
  final double? size;
  final Color? color;

  const Icon(this.asset, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 32,
      height: size ?? 32,
      child: VectorGraphic(
        loader: AssetBytesLoader(asset),
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
