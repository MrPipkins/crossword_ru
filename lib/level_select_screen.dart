import 'package:flutter/material.dart';
import 'levels.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  int maxUnlocked = 1;

  List<Color> _colorsForLevel(int id) {
    if (id <= 5) return [const Color(0xFF1565C0), const Color(0xFF42A5F5)];
    if (id <= 10) return [const Color(0xFF4A148C), const Color(0xFF7B1FA2)];
    if (id <= 15) return [const Color(0xFFAD1457), const Color(0xFFE91E63)];
    if (id <= 20) return [const Color(0xFF00695C), const Color(0xFF00897B)];
    if (id <= 25) return [const Color(0xFFE65100), const Color(0xFFFB8C00)];
    return [const Color(0xFF283593), const Color(0xFF3F51B5)];
  }

  void _openLevel(int index) {
    final level = allLevels[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(
          level: level,
          onComplete: () {
            Navigator.pop(context);
            setState(() {
              if (level.id >= maxUnlocked) {
                maxUnlocked = level.id + 1;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'КРОССВОРД',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Составляй слова',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: allLevels.length,
                    itemBuilder: (ctx, i) {
                      final id = allLevels[i].id;
                      final unlocked = id <= maxUnlocked;
                      final completed = id < maxUnlocked;
                      final colors = _colorsForLevel(id);

                      return GestureDetector(
                        onTap: unlocked ? () => _openLevel(i) : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            gradient: unlocked
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: colors,
                                  )
                                : null,
                            color: unlocked ? null : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: completed
                                ? Border.all(color: Colors.amber, width: 2)
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: unlocked
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (completed)
                                      const Icon(Icons.star, color: Colors.amber, size: 16),
                                    Text(
                                      '$id',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : Icon(
                                  Icons.lock,
                                  color: Colors.white.withValues(alpha: 0.3),
                                  size: 20,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
