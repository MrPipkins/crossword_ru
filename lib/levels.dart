import 'models.dart';

const h = true;
const v = false;

// --- 3 буквы: 10 уровней ---
final List<LevelData> levels3 = [
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
  LevelData(id: 6, words: [
    WordPlacement('ЛЕС', 0, 0, h),
    WordPlacement('СОМ', 0, 2, v),
  ]),
  LevelData(id: 7, words: [
    WordPlacement('ДЫМ', 0, 0, h),
    WordPlacement('МАК', 0, 2, v),
  ]),
  LevelData(id: 8, words: [
    WordPlacement('ЧАС', 0, 0, h),
    WordPlacement('СУП', 0, 2, v),
  ]),
  LevelData(id: 9, words: [
    WordPlacement('ШАР', 0, 0, h),
    WordPlacement('РАК', 0, 2, v),
    WordPlacement('ЛАК', 2, 0, h),
  ]),
  LevelData(id: 10, words: [
    WordPlacement('БОК', 0, 0, h),
    WordPlacement('КОМ', 0, 2, v),
    WordPlacement('ТОМ', 2, 0, h),
  ]),
];

// --- 4 буквы: 10 уровней ---
final List<LevelData> levels4 = [
  LevelData(id: 1, words: [
    WordPlacement('РЕКА', 0, 0, h),
    WordPlacement('КРОТ', 0, 2, v),
  ]),
  LevelData(id: 2, words: [
    WordPlacement('КОРА', 0, 0, h),
    WordPlacement('РОЗА', 0, 2, v),
  ]),
  LevelData(id: 3, words: [
    WordPlacement('ЛУНА', 0, 0, h),
    WordPlacement('НОРА', 0, 2, v),
  ]),
  LevelData(id: 4, words: [
    WordPlacement('МОСТ', 0, 0, h),
    WordPlacement('СТУЛ', 0, 2, v),
  ]),
  LevelData(id: 5, words: [
    WordPlacement('ГОРА', 0, 0, h),
    WordPlacement('РУКА', 0, 2, v),
  ]),
  LevelData(id: 6, words: [
    WordPlacement('ЛИСТ', 0, 0, h),
    WordPlacement('СТОЛ', 0, 2, v),
  ]),
  LevelData(id: 7, words: [
    WordPlacement('ПОРТ', 0, 0, h),
    WordPlacement('РОТА', 0, 2, v),
  ]),
  LevelData(id: 8, words: [
    WordPlacement('ТЕЛО', 0, 0, h),
    WordPlacement('ЛОСЬ', 0, 2, v),
  ]),
  LevelData(id: 9, words: [
    WordPlacement('ДУГА', 0, 0, h),
    WordPlacement('ГУСЬ', 0, 2, v),
    WordPlacement('КУСТ', 2, 0, h),
  ]),
  LevelData(id: 10, words: [
    WordPlacement('ВОДА', 0, 0, h),
    WordPlacement('ДАЛЬ', 0, 2, v),
    WordPlacement('СОЛЬ', 2, 0, h),
  ]),
];

// --- 5 букв: 10 уровней ---
final List<LevelData> levels5 = [
  LevelData(id: 1, words: [
    WordPlacement('КНИГА', 0, 0, h),
    WordPlacement('НИТКА', 0, 1, v),
  ]),
  LevelData(id: 2, words: [
    WordPlacement('МАСЛО', 0, 0, h),
    WordPlacement('СИРОП', 0, 2, v),
  ]),
  LevelData(id: 3, words: [
    WordPlacement('ПИЛОТ', 0, 0, h),
    WordPlacement('ЛИМОН', 0, 2, v),
  ]),
  LevelData(id: 4, words: [
    WordPlacement('КАРТА', 0, 0, h),
    WordPlacement('РАДИО', 0, 2, v),
  ]),
  LevelData(id: 5, words: [
    WordPlacement('ОКЕАН', 0, 0, h),
    WordPlacement('КЕФИР', 0, 1, v),
  ]),
  LevelData(id: 6, words: [
    WordPlacement('МЕЧТА', 0, 0, h),
    WordPlacement('ЧАШКА', 0, 2, v),
  ]),
  LevelData(id: 7, words: [
    WordPlacement('ЗАВОД', 0, 0, h),
    WordPlacement('ВЕДРО', 0, 2, v),
  ]),
  LevelData(id: 8, words: [
    WordPlacement('ГЕРОЙ', 0, 0, h),
    WordPlacement('РОМАН', 0, 2, v),
  ]),
  LevelData(id: 9, words: [
    WordPlacement('БАЛЕТ', 0, 0, h),
    WordPlacement('ЛЕНТА', 0, 2, v),
  ]),
  LevelData(id: 10, words: [
    WordPlacement('АТЛАС', 0, 0, h),
    WordPlacement('ЛИМОН', 0, 2, v),
    WordPlacement('СИРОП', 0, 4, v),
  ]),
];

// --- 6 букв: 10 уровней ---
final List<LevelData> levels6 = [
  LevelData(id: 1, words: [
    WordPlacement('КОРОВА', 0, 0, h),
    WordPlacement('РОДИНА', 0, 2, v),
  ]),
  LevelData(id: 2, words: [
    WordPlacement('КНОПКА', 0, 0, h),
    WordPlacement('ПАЛУБА', 0, 3, v),
  ]),
  LevelData(id: 3, words: [
    WordPlacement('РАКЕТА', 0, 0, h),
    WordPlacement('КИРПИЧ', 0, 2, v),
  ]),
  LevelData(id: 4, words: [
    WordPlacement('СОЛНЦЕ', 0, 0, h),
    WordPlacement('НЕКТАР', 0, 3, v),
  ]),
  LevelData(id: 5, words: [
    WordPlacement('МОНЕТА', 0, 0, h),
    WordPlacement('НОЧЛЕГ', 0, 2, v),
  ]),
  LevelData(id: 6, words: [
    WordPlacement('КАМЕНЬ', 0, 0, h),
    WordPlacement('МИНУТА', 0, 2, v),
  ]),
  LevelData(id: 7, words: [
    WordPlacement('ЛОПАТА', 0, 0, h),
    WordPlacement('ПЛИТКА', 0, 2, v),
  ]),
  LevelData(id: 8, words: [
    WordPlacement('ПОГОДА', 0, 0, h),
    WordPlacement('ГИТАРА', 0, 2, v),
  ]),
  LevelData(id: 9, words: [
    WordPlacement('РАБОТА', 0, 0, h),
    WordPlacement('БОТИНОК', 0, 2, v),
  ]),
  LevelData(id: 10, words: [
    WordPlacement('МАШИНА', 0, 0, h),
    WordPlacement('ШПАГАТ', 0, 2, v),
    WordPlacement('НАБОР', 0, 4, v),
  ]),
];

final Map<String, List<LevelData>> allCategories = {
  '3': levels3,
  '4': levels4,
  '5': levels5,
  '6': levels6,
};
