import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

// Runs bin/compat.dart the way `dart run bin/compat.dart` does, types two
// pairs into it, and checks what main() prints.
Future<ProcessResult> runProgram(String path, String input) async {
  final process = await Process.start(Platform.resolvedExecutable, ['run', path]);
  process.stdin.write(input);
  await process.stdin.close();
  final out = process.stdout.transform(utf8.decoder).join();
  final err = process.stderr.transform(utf8.decoder).join();
  final code = await process.exitCode.timeout(const Duration(seconds: 90));
  return ProcessResult(process.pid, code, await out, await err);
}

void main() {
  group('main() in bin/compat.dart', () {
    test('bin/compat.dart exists and declares main()', () {
      final file = File('bin/compat.dart');
      expect(file.existsSync(), isTrue, reason: 'Keep your program in bin/compat.dart.');
      expect(file.readAsStringSync(), matches(RegExp(r'\bmain\s*\(')),
          reason: 'bin/compat.dart needs a main() function so `dart run` can start it.');
    });

    test('runs without error, scores each pair and counts the matches', () async {
      // Pair 1 shares two interests and is 2 years apart: 60, a match.
      // Pair 2 shares nothing and is 12 years apart: 0, keep swiping.
      const input = '2\n'
          'Hinata\n17\nvolleyball,food\nKageyama\n19\nVolleyball,milk,food\n'
          'Light\n18\nchess\nL\n30\nsweets\n';
      final result = await runProgram('bin/compat.dart', input);
      expect(result.exitCode, equals(0),
          reason: '`dart run bin/compat.dart` must finish without an error.\n${result.stderr}');
      final output = result.stdout as String;
      expect(output, contains('60'), reason: 'Print the score for each pair.');
      expect("It's a match!".allMatches(output).length, equals(1),
          reason: "Print It's a match! once for each pair that matches.");
      expect('Keep swiping'.allMatches(output).length, equals(1),
          reason: 'Print Keep swiping for each pair that does not match.');
      final lastLine = output.trim().split('\n').last;
      expect(lastLine, matches(RegExp(r'\b1\b')),
          reason: 'End by printing how many pairs matched.');
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
