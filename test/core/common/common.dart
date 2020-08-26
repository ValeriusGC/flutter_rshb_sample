DateTime get now => DateTime.now();

///
testDelimiter([int length = 80, bool time = true]) =>
    '-'.repeat(length) + (time ? '\n$now' : '\n');

///
extension StringTyper on String {
  /// repeating string [cnt] times
  String repeat([int cnt = 2]){
    return List.generate(cnt, (i) => this).join();
  }
}
