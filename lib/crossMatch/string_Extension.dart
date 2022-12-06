// ignore_for_file: file_names

import 'package:lostfoundapp/crossMatch/string_crossmatch._base.dart';

extension StringExtensions on String? {
  double crossMatch(String? other) =>
      StringCrossMatch.crosMatchString(this, other);

  // bool contains(Pattern other, [int startIndex = 0]) {
  //   throw UnimplementedError();
  // }
}
