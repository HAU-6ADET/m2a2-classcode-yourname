import 'dart:convert';
import 'dart:io';

import 'package:m2a2/compat.dart';
import 'package:test/test.dart';

void main() {
  group('sharedInterests', () {
    test('counts interests in both lists', () => expect(sharedInterests(['music', 'cooking', 'games'], ['games', 'music']), equals(2)));
    test('ignores capital letters', () => expect(sharedInterests(['Music'], ['music']), equals(1)));
    test('no overlap is 0', () => expect(sharedInterests(['art'], ['sports']), equals(0)));
  });

  group('ageGap', () {
    test('is positive either way', () {
      expect(ageGap(17, 20), equals(3));
      expect(ageGap(20, 17), equals(3));
    });
  });

  group('compatibility', () {
    test('20 points per shared interest', () => expect(compatibility(['a', 'b'], 20, ['a', 'b'], 30), equals(40)));
    test('adds 20 when the age gap is exactly 3', () => expect(compatibility(['a'], 20, ['a'], 23), equals(40)));
    test('no age bonus when the gap is 4', () => expect(compatibility(['a'], 20, ['a'], 24), equals(20)));
    test('interest points stop at 80', () => expect(compatibility(['a', 'b', 'c', 'd', 'e'], 20, ['a', 'b', 'c', 'd', 'e'], 40), equals(80)));
    test('never more than 100', () => expect(compatibility(['a', 'b', 'c', 'd', 'e'], 20, ['a', 'b', 'c', 'd', 'e'], 21), equals(100)));
    test('nothing shared and far apart is 0', () => expect(compatibility(['a'], 18, ['b'], 30), equals(0)));
  });

  group('isMatch', () {
    test('60 is a match', () => expect(isMatch(60), isTrue));
    test('59 is not', () => expect(isMatch(59), isFalse));
  });

  group("Student details in your private activity copy", () {
    late Map<String, dynamic> info;
    setUpAll(() {
      info = jsonDecode(File("student.json").readAsStringSync()) as Map<String, dynamic>;
    });
    for (final field in ["fullName", "studentNumber", "studentEmail", "classCode", "githubAccount", "room", "pcNumber"]) {
      test("$field is filled in", () {
        final value = info[field];
        expect(value, isA<String>(), reason: "Set $field in student.json.");
        expect((value as String).trim(), isNotEmpty, reason: "Set $field in your private copy of student.json.");
      });
    }
    test("classCode identifies one of the new ADET classes", () {
      expect(info["classCode"], isIn(["2223", "2293", "2182", "2294"]), reason: "Use the class code shown in your own Canvas course.");
    });
  });
}
