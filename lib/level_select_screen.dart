import 'package:flutter/material.dart';
import 'levels.dart';
import 'models.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  // Прогресс для каждой категории
  Map<String, int> maxUnlocked = {'3': 1, '4': 1, '5': 1, '6': 1};

  static const categoryInfo = [
    {'key': '3', 'title': '3 буквы', 'subtitle': 'Легко', 'icon': Icons.looks_3},
    {'key': '4', 'title': '4 буквы', 'subtitle': 'Средне', 'icon': Icons.looks_4},
    {'key': '5', 'title': '5 букв', 'subtitle': 'Сложно', 'icon': Icons.looks_5},
    {'key': '6', 'title': '6 букв', 'subtitle': 'Эксперт', 'icon': Icons.looks_6},
  ];

  static const categoryColors = [
    [Color(0xFF1565C0), Color(0xFF42A5F5)],
    [Color(0xFF4A148C), Color(0xFF7B1FA2)],
    [Color(0xFFAD1457), Color(0xFFE91E63)],
    [Color(0xFFE65100), Color(0xFFFB8C00)],
  ];

  void _openCategory(BuildContext context, int catIndex) {
    final info = categoryInfo[catIndex];
    final key = info['key'] as String;
    final levels = allCategories[key]!;
    final colors = categoryColors[catIndex];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _LevelGridScreen(
          title: info['title'] as String,
          categoryKey: key,
          levels: levels,
          colors: colors,
          catIndex: catIndex,
          maxUnlocked: maxUnlocked[key]!,
          onProgress: (newMax) {
            setState(() {
              maxUnlocked[key] = newMax;
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
              const SizedBox(height: 40),
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
              const SizedBox(height: 40),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    itemCount: categoryInfo.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (ctx, i) {
                      final info = categoryInfo[i];
                      final key = info['key'] as String;
                      final colors = categoryColors[i];
                      final unlocked = maxUnlocked[key]!;
                      final total = allCategories[key]!.length;
                      final completed = unlocked - 1;

                      return GestureDetector(
                        onTap: () => _openCategory(context, i),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: colors,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(
                                  info['icon'] as IconData,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        info['title'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        info['subtitle'] as String,
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$completed/$total',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: completed / total,
                                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.chevron_right, color: Colors.white70),
                              ],
                            ),
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

class _LevelGridScreen extends StatefulWidget {
  final String title;
  final String categoryKey;
  final List<LevelData> levels;
  final List<Color> colors;
  final int maxUnlocked;
  final int catIndex;
  final ValueChanged<int> onProgress;

  const _LevelGridScreen({
    required this.title,
    required this.categoryKey,
    required this.levels,
    required this.colors,
    required this.maxUnlocked,
    required this.catIndex,
    required this.onProgress,
  });

  @override
  State<_LevelGridScreen> createState() => _LevelGridScreenState();
}

class _LevelGridScreenState extends State<_LevelGridScreen> {
  late int maxUnlocked;

  @override
  void initState() {
    super.initState();
    maxUnlocked = widget.maxUnlocked;
  }

  void _openLevel(int index) {
    final level = widget.levels[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(
          level: level,
          bgIndex: widget.catIndex,
          onComplete: () {
            Navigator.pop(context);
            setState(() {
              if (level.id >= maxUnlocked) {
                maxUnlocked = level.id + 1;
                widget.onProgress(maxUnlocked);
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.colors[0],
              widget.colors[1],
              widget.colors[1].withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                    ),
                    itemCount: widget.levels.length,
                    itemBuilder: (ctx, i) {
                      final id = widget.levels[i].id;
                      final unlocked = id <= maxUnlocked;
                      final completed = id < maxUnlocked;

                      return GestureDetector(
                        onTap: unlocked ? () => _openLevel(i) : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: unlocked
                                ? Colors.white.withValues(alpha: 0.25)
                                : Colors.white.withValues(alpha: 0.08),
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
                                        fontSize: 20,
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
