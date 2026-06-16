import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:test/test.dart';

Future<String> _run(List<String> inputs) async {
  final process = await Process.start('dart', ['run', 'bin/numbers.dart']);
  for (final line in inputs) {
    process.stdin.writeln(line);
  }
  await process.stdin.flush();
  await process.stdin.close();
  final out = await process.stdout.transform(utf8.decoder).join();
  await process.exitCode;
  return out;
}

/// Pull every number out of the program's output so we can check a computed
/// value is present without caring how the program labels or formats it.
List<num> _numbers(String out) => RegExp(r'-?\d+(?:\.\d+)?')
    .allMatches(out)
    .map((m) => num.parse(m.group(0)!))
    .toList();

bool _has(String out, num value) =>
    _numbers(out).any((n) => (n - value).abs() < 1e-9);

/// The tests don't hardcode the expected sum/average. Two sets of 10 numbers
/// are generated (seeded, so every run is identical), the answers are computed
/// here, and we check the program prints them.
void main() {
  test('student.json is filled in', () {
    final info = jsonDecode(File('student.json').readAsStringSync())
        as Map<String, dynamic>;
    for (final field in [
      'classCode',
      'fullName',
      'studentNumber',
      'studentEmail',
      'personalEmail',
      'githubAccount',
    ]) {
      expect(info[field], isNotEmpty, reason: 'Set "$field" in student.json');
    }
  });

  final rng = Random(2026);
  final setA = List.generate(10, (_) => rng.nextInt(50) + 1);
  final setB = List.generate(10, (_) => rng.nextInt(50) + 1);

  for (final entry in {'first': setA, 'second': setB}.entries) {
    final nums = entry.value;
    final sum = nums.reduce((a, b) => a + b);
    final average = sum / 10;

    group('Sum and average (${entry.key} set: $nums)', () {
      late String out;
      setUpAll(() async => out = await _run(nums.map((n) => '$n').toList()));

      test('sum is $sum',
          () => expect(_has(out, sum), isTrue, reason: 'the 10 numbers add to $sum'));
      test('average is $average',
          () => expect(_has(out, average), isTrue, reason: '$sum / 10 = $average'));
    }, timeout: const Timeout(Duration(seconds: 60)));
  }
}
