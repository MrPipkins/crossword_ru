import 'package:flutter_test/flutter_test.dart';
import 'package:crossword_ru/main.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const CrosswordApp());
    expect(find.text('КРОССВОРД'), findsOneWidget);
  });
}
