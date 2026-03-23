import 'package:flutter/widgets.dart';
import 'package:vector_graphics/vector_graphics.dart';

class FrendzIcon extends StatelessWidget {
  final String asset;
  final double? size;
  final Color? color;

  const FrendzIcon(this.asset, {super.key, this.size = 32, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: VectorGraphic(
        loader: AssetBytesLoader(asset, packageName: 'frendz_flutter_icons'),
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
