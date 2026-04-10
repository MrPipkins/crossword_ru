import 'dart:math';
import 'package:flutter/material.dart';
import 'models.dart';
import 'hints.dart';

class GameScreen extends StatefulWidget {
  final LevelData level;
  final VoidCallback onComplete;
  final int bgIndex;

  const GameScreen({super.key, required this.level, required this.onComplete, this.bgIndex = 0});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late Set<String> foundWords;
  late Set<(int, int)> revealedCells;
  late List<String> circleLetters;
  List<int> selectedIndices = [];
  String currentWord = '';
  Offset? currentDragPos;
  bool levelComplete = false;

  @override
  void initState() {
    super.initState();
    foundWords = {};
    revealedCells = {};
    circleLetters = widget.level.circleLetters;
  }

  void _onWordSubmitted(String word) {
    for (final wp in widget.level.words) {
      if (wp.word == word && !foundWords.contains(word)) {
        setState(() {
          foundWords.add(word);
          for (final cell in wp.cells) {
            revealedCells.add(cell);
          }
        });
        if (foundWords.length == widget.level.words.length) {
          levelComplete = true;
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            _showCompleteDialog();
          });
        }
        return;
      }
    }
  }

  void _showHint() {
    final unguessed = widget.level.words
        .where((wp) => !foundWords.contains(wp.word))
        .toList();
    if (unguessed.isEmpty) return;
    final wp = unguessed[Random().nextInt(unguessed.length)];
    final hint = wordHints[wp.word] ?? 'Слово из ${wp.word.length} букв';
    final colors = _themeColors;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: colors[0], size: 28),
            const SizedBox(width: 8),
            const Text('Подсказка', style: TextStyle(fontSize: 22)),
          ],
        ),
        content: Text(
          hint,
          style: const TextStyle(fontSize: 18, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Понятно', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Отлично!', style: TextStyle(fontSize: 28)),
        content: Text(
          'Уровень ${widget.level.id} пройден!',
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onComplete();
            },
            child: const Text('Далее', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  static const _allThemes = [
    [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFF90CAF9)],
    [Color(0xFF4A148C), Color(0xFF7B1FA2), Color(0xFFCE93D8)],
    [Color(0xFFAD1457), Color(0xFFE91E63), Color(0xFFF48FB1)],
    [Color(0xFFE65100), Color(0xFFFB8C00), Color(0xFFFFCC80)],
  ];

  static const _backgrounds = [
    'assets/backgrounds/bg1.jpg',
    'assets/backgrounds/bg2.jpg',
    'assets/backgrounds/bg3.jpg',
    'assets/backgrounds/bg4.jpg',
  ];

  List<Color> get _themeColors => _allThemes[widget.bgIndex % _allThemes.length];
  String get _backgroundImage => _backgrounds[widget.bgIndex % _backgrounds.length];

  @override
  Widget build(BuildContext context) {
    final colors = _themeColors;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _backgroundImage,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors[0].withValues(alpha: 0.5),
                  colors[1].withValues(alpha: 0.3),
                  colors[2].withValues(alpha: 0.5),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(flex: 5, child: _buildGrid()),
                const SizedBox(height: 8),
                Text(
                  currentWord,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(flex: 5, child: _buildLetterCircle()),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            'Уровень ${widget.level.id}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 32),
            onPressed: _showHint,
            tooltip: 'Подсказка',
            iconSize: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final level = widget.level;
    final rows = level.gridRows;
    final cols = level.gridCols;
    final gridMap = level.gridLetters;
    final colors = _themeColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            final maxH = constraints.maxHeight;
            final cellSize = min(min(maxW / cols, maxH / rows), 48.0);
            final gap = 3.0;
            final totalW = cols * (cellSize + gap) - gap;
            final totalH = rows * (cellSize + gap) - gap;

            return SizedBox(
              width: totalW,
              height: totalH,
              child: Stack(
                children: [
                  for (int r = 0; r < rows; r++)
                    for (int c = 0; c < cols; c++)
                      if (gridMap.containsKey((r, c)))
                        Positioned(
                          left: c * (cellSize + gap),
                          top: r * (cellSize + gap),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: cellSize,
                            height: cellSize,
                            decoration: BoxDecoration(
                              color: revealedCells.contains((r, c))
                                  ? colors[0].withValues(alpha: 0.85)
                                  : Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: revealedCells.contains((r, c))
                                ? Text(
                                    gridMap[(r, c)]!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: cellSize * 0.55,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLetterCircle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight) * 0.85;
        final radius = size / 2 - 30;
        final center = Offset(size / 2, size / 2);
        final letterRadius = 26.0;
        final colors = _themeColors;

        // Calculate letter positions
        final positions = <Offset>[];
        for (int i = 0; i < circleLetters.length; i++) {
          final angle = -pi / 2 + (2 * pi * i / circleLetters.length);
          positions.add(Offset(
            center.dx + radius * cos(angle),
            center.dy + radius * sin(angle),
          ));
        }

        int? hitTest(Offset pos) {
          for (int i = 0; i < positions.length; i++) {
            if ((pos - positions[i]).distance <= letterRadius + 8) {
              return i;
            }
          }
          return null;
        }

        return Center(
          child: GestureDetector(
            onPanStart: (details) {
              final box = context.findRenderObject() as RenderBox;
              final localPos = box.globalToLocal(details.globalPosition);
              // Adjust for centering
              final offset = Offset(
                (constraints.maxWidth - size) / 2,
                (constraints.maxHeight - size) / 2,
              );
              final adjustedPos = localPos - offset;
              final idx = hitTest(adjustedPos);
              if (idx != null) {
                setState(() {
                  selectedIndices = [idx];
                  currentWord = circleLetters[idx];
                  currentDragPos = adjustedPos;
                });
              }
            },
            onPanUpdate: (details) {
              if (selectedIndices.isEmpty) return;
              final box = context.findRenderObject() as RenderBox;
              final localPos = box.globalToLocal(details.globalPosition);
              final offset = Offset(
                (constraints.maxWidth - size) / 2,
                (constraints.maxHeight - size) / 2,
              );
              final adjustedPos = localPos - offset;
              setState(() {
                currentDragPos = adjustedPos;
              });
              final idx = hitTest(adjustedPos);
              if (idx != null && !selectedIndices.contains(idx)) {
                setState(() {
                  selectedIndices.add(idx);
                  currentWord += circleLetters[idx];
                });
              }
              // Allow going back
              if (idx != null &&
                  selectedIndices.length >= 2 &&
                  idx == selectedIndices[selectedIndices.length - 2]) {
                setState(() {
                  selectedIndices.removeLast();
                  currentWord = selectedIndices.map((i) => circleLetters[i]).join();
                });
              }
            },
            onPanEnd: (_) {
              if (currentWord.isNotEmpty) {
                _onWordSubmitted(currentWord);
              }
              setState(() {
                selectedIndices = [];
                currentWord = '';
                currentDragPos = null;
              });
            },
            child: SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _CirclePainter(
                  letters: circleLetters,
                  positions: positions,
                  selectedIndices: selectedIndices,
                  letterRadius: letterRadius,
                  accentColor: colors[0],
                  dragPos: currentDragPos,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CirclePainter extends CustomPainter {
  final List<String> letters;
  final List<Offset> positions;
  final List<int> selectedIndices;
  final double letterRadius;
  final Color accentColor;
  final Offset? dragPos;

  _CirclePainter({
    required this.letters,
    required this.positions,
    required this.selectedIndices,
    required this.letterRadius,
    required this.accentColor,
    this.dragPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background circle
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 5,
      bgPaint,
    );

    // Draw connecting lines
    if (selectedIndices.length >= 2) {
      final linePaint = Paint()
        ..color = accentColor.withValues(alpha: 0.8)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(positions[selectedIndices[0]].dx, positions[selectedIndices[0]].dy);
      for (int i = 1; i < selectedIndices.length; i++) {
        path.lineTo(positions[selectedIndices[i]].dx, positions[selectedIndices[i]].dy);
      }
      canvas.drawPath(path, linePaint);
    }

    // Draw line to current drag position
    if (selectedIndices.isNotEmpty && dragPos != null) {
      final dragLinePaint = Paint()
        ..color = accentColor.withValues(alpha: 0.4)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      final lastPos = positions[selectedIndices.last];
      canvas.drawLine(lastPos, dragPos!, dragLinePaint);
    }

    // Draw letter circles
    for (int i = 0; i < letters.length; i++) {
      final isSelected = selectedIndices.contains(i);
      final circlePaint = Paint()
        ..color = isSelected ? accentColor : Colors.white.withValues(alpha: 0.9)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(positions[i], letterRadius, circlePaint);

      if (!isSelected) {
        final borderPaint = Paint()
          ..color = accentColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(positions[i], letterRadius, borderPaint);
      }

      // Draw letter
      final textPainter = TextPainter(
        text: TextSpan(
          text: letters[i],
          style: TextStyle(
            color: isSelected ? Colors.white : accentColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          positions[i].dx - textPainter.width / 2,
          positions[i].dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) => true;
}
