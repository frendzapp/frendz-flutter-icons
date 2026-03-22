import 'dart:io';

import 'package:path/path.dart' as path;

void main() async {
  final inputDirectory = Directory('raw');
  final outputDirectory = Directory('assets');
  final outputFile = File('lib/src/icons.dart');

  if (!inputDirectory.existsSync()) {
    inputDirectory.createSync();
    return;
  }

  if (!outputDirectory.existsSync()) outputDirectory.createSync();

  final buffer = StringBuffer();
  buffer.writeln("import 'package:vector_graphics/vector_graphics.dart';\n");
  buffer.writeln("class FrendzIcons {");

  final files = inputDirectory.listSync().whereType<File>().toList();
  for (final file in files) {
    if (path.extension(file.path).toLowerCase() == '.svg') {
      final name = path.basenameWithoutExtension(file.path);
      final outputPath = 'assets/$name.vec';

      final result = await Process.run('dart', [
        'run',
        'vector_graphics_compiler',
        '-i',
        file.path,
        '-o',
        outputPath,
      ]);
      if (result.exitCode != 0) continue;

      final variableName = _toCamelCase(name);
      buffer.writeln(
        "  static const AssetBytesLoader $variableName = AssetBytesLoader('$outputPath');",
      );
    }
  }

  buffer.writeln("}");
  await outputFile.writeAsString(buffer.toString());
}

// helpers
String _toCamelCase(String text) {
  final words = text.split(RegExp(r'[- ]+'));
  final capitalized = words
      .map((word) {
        if (word.isEmpty) return "";
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      })
      .join('');

  return capitalized;
}
