import 'dart:math';

class WordPlacement {
  final String word;
  final int row;
  final int col;
  final bool isHorizontal;

  const WordPlacement(this.word, this.row, this.col, this.isHorizontal);

  List<(int, int)> get cells {
    return List.generate(word.length, (i) {
      if (isHorizontal) return (row, col + i);
      return (row + i, col);
    });
  }
}

class LevelData {
  final int id;
  final List<WordPlacement> words;

  const LevelData({required this.id, required this.words});

  List<String> get circleLetters {
    Map<String, int> maxCounts = {};
    for (final wp in words) {
      Map<String, int> wc = {};
      for (final ch in wp.word.split('')) {
        wc[ch] = (wc[ch] ?? 0) + 1;
      }
      for (final e in wc.entries) {
        maxCounts[e.key] = max(maxCounts[e.key] ?? 0, e.value);
      }
    }
    List<String> result = [];
    for (final e in maxCounts.entries) {
      for (int i = 0; i < e.value; i++) {
        result.add(e.key);
      }
    }
    return result;
  }

  int get gridRows {
    int maxRow = 0;
    for (final wp in words) {
      final endRow = wp.isHorizontal ? wp.row : wp.row + wp.word.length - 1;
      maxRow = max(maxRow, endRow);
    }
    return maxRow + 1;
  }

  int get gridCols {
    int maxCol = 0;
    for (final wp in words) {
      final endCol = wp.isHorizontal ? wp.col + wp.word.length - 1 : wp.col;
      maxCol = max(maxCol, endCol);
    }
    return maxCol + 1;
  }

  Map<(int, int), String> get gridLetters {
    Map<(int, int), String> grid = {};
    for (final wp in words) {
      final chars = wp.word.split('');
      for (int i = 0; i < chars.length; i++) {
        final r = wp.isHorizontal ? wp.row : wp.row + i;
        final c = wp.isHorizontal ? wp.col + i : wp.col;
        grid[(r, c)] = chars[i];
      }
    }
    return grid;
  }
}
