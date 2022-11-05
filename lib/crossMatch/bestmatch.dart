import 'package:lostfoundapp/crossMatch/ratings.dart';

class BestMatch {
  BestMatch(
      {required this.ratings,
      required this.bestMatch,
      required this.bestMatchIndex});

  List<Rating> ratings;

  Rating bestMatch;

  int bestMatchIndex;

  @override
  String toString() => '$bestMatchIndex:${bestMatch.toString()}';
}
