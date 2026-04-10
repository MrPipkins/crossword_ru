import 'models.dart';

const h = true;
const v = false;

final List<LevelData> allLevels = [
  // --- Levels 1-5: Easy (2-3 words, 3 letters) ---
  LevelData(id: 1, words: [
    WordPlacement('КОТ', 0, 0, h),
    WordPlacement('ТОК', 0, 2, v),
  ]),
  LevelData(id: 2, words: [
    WordPlacement('СОН', 0, 0, h),
    WordPlacement('НОС', 0, 2, v),
  ]),
  LevelData(id: 3, words: [
    WordPlacement('ДОМ', 1, 0, h),
    WordPlacement('СОК', 0, 1, v),
  ]),
  LevelData(id: 4, words: [
    WordPlacement('ЛУК', 0, 0, h),
    WordPlacement('КОТ', 0, 2, v),
  ]),
  LevelData(id: 5, words: [
    WordPlacement('МАК', 0, 0, h),
    WordPlacement('КОТ', 0, 2, v),
    WordPlacement('ЛОТ', 2, 0, h),
  ]),

  // --- Levels 6-10: Medium Easy (2-3 words, 4-letter) ---
  LevelData(id: 6, words: [
    WordPlacement('РЕКА', 0, 0, h),
    WordPlacement('КРОТ', 0, 2, v),
  ]),
  LevelData(id: 7, words: [
    WordPlacement('КОРА', 0, 0, h),
    WordPlacement('РОЗА', 0, 2, v),
    WordPlacement('КОЗА', 2, 0, h),
  ]),
  LevelData(id: 8, words: [
    WordPlacement('ЛИСТ', 0, 0, h),
    WordPlacement('СТУЛ', 0, 2, v),
    WordPlacement('ЛОТО', 1, 0, h),
  ]),
  LevelData(id: 9, words: [
    WordPlacement('РЕКА', 0, 0, h),
    WordPlacement('КРОТ', 0, 2, v),
    WordPlacement('РОТА', 3, 0, h),
  ]),
  LevelData(id: 10, words: [
    WordPlacement('ЛУНА', 0, 0, h),
    WordPlacement('НОРА', 0, 2, v),
    WordPlacement('КОРА', 2, 0, h),
  ]),

  // --- Levels 11-15: Medium (2-3 words, 5-letter) ---
  LevelData(id: 11, words: [
    WordPlacement('ЗАМОК', 0, 0, h),
    WordPlacement('МОСТ', 0, 2, v),
    WordPlacement('ЗАКОН', 0, 0, v),
  ]),
  LevelData(id: 12, words: [
    WordPlacement('КНИГА', 0, 0, h),
    WordPlacement('НИТКА', 0, 1, v),
  ]),
  LevelData(id: 13, words: [
    WordPlacement('МАСЛО', 0, 0, h),
    WordPlacement('СИРОП', 0, 2, v),
  ]),
  LevelData(id: 14, words: [
    WordPlacement('ПОВАР', 0, 0, h),
    WordPlacement('ОТВЕТ', 0, 1, v),
  ]),
  LevelData(id: 15, words: [
    WordPlacement('ПИЛОТ', 0, 0, h),
    WordPlacement('ЛИМОН', 0, 2, v),
  ]),

  // --- Levels 16-20: Medium Hard ---
  LevelData(id: 16, words: [
    WordPlacement('КАРТА', 0, 0, h),
    WordPlacement('РАДИО', 0, 2, v),
  ]),
  LevelData(id: 17, words: [
    WordPlacement('ОКЕАН', 0, 0, h),
    WordPlacement('КЕФИР', 0, 1, v),
  ]),
  LevelData(id: 18, words: [
    WordPlacement('СПОРТ', 0, 0, h),
    WordPlacement('ПОВАР', 0, 1, v),
  ]),
  LevelData(id: 19, words: [
    WordPlacement('ШКОЛА', 0, 0, h),
    WordPlacement('КНИГА', 0, 1, v),
  ]),
  LevelData(id: 20, words: [
    WordPlacement('ПТИЦА', 0, 0, h),
    WordPlacement('ТЕСТО', 0, 1, v),
  ]),

  // --- Levels 21-25: Hard ---
  LevelData(id: 21, words: [
    WordPlacement('МЕЧТА', 0, 0, h),
    WordPlacement('ЧАШКА', 0, 2, v),
  ]),
  LevelData(id: 22, words: [
    WordPlacement('ЗАВОД', 0, 0, h),
    WordPlacement('ВЕДРО', 0, 2, v),
  ]),
  LevelData(id: 23, words: [
    WordPlacement('ГЕРОЙ', 0, 0, h),
    WordPlacement('РОМАН', 0, 2, v),
  ]),
  LevelData(id: 24, words: [
    WordPlacement('ФОРМА', 0, 0, h),
    WordPlacement('РАЙОН', 0, 2, v),
  ]),
  LevelData(id: 25, words: [
    WordPlacement('ДИВАН', 0, 0, h),
    WordPlacement('ВАГОН', 0, 2, v),
  ]),

  // --- Levels 26-30: Expert ---
  LevelData(id: 26, words: [
    WordPlacement('БАЛЕТ', 0, 0, h),
    WordPlacement('ЛЕНТА', 0, 2, v),
  ]),
  LevelData(id: 27, words: [
    WordPlacement('ГОРОХ', 0, 0, h),
    WordPlacement('РАЙОН', 0, 2, v),
  ]),
  LevelData(id: 28, words: [
    WordPlacement('МУЗЕЙ', 0, 0, h),
    WordPlacement('ЗЕРНО', 0, 2, v),
  ]),
  LevelData(id: 29, words: [
    WordPlacement('ФРУКТ', 0, 0, h),
    WordPlacement('УДАЧА', 0, 2, v),
  ]),
  LevelData(id: 30, words: [
    WordPlacement('АТЛАС', 0, 0, h),
    WordPlacement('ЛИМОН', 0, 2, v),
    WordPlacement('СИРОП', 0, 4, v),
  ]),
];
