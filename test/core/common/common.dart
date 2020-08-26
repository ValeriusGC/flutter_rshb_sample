import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;

DateTime get now => DateTime.now();

///
testDelimiter([int length = 80, bool time = true]) =>
    '-'.repeat(length) + (time ? '\n$now' : '\n');

///
extension StringTyper on String {
  /// repeating string [cnt] times
  String repeat([int cnt = 2]) {
    return List.generate(cnt, (i) => this).join();
  }
}

final random = Random();
String tempPath =
    path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');

Future<Directory> getTempDir() async {
  var name = random.nextInt(pow(2, 32) as int);
  var dir = Directory(path.join(tempPath, '${name}_tmp'));
  if (await dir.exists()) {
    await dir.delete(recursive: true);
  }
  await dir.create(recursive: true);
  return dir;
}
