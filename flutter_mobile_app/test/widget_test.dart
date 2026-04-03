import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_mobile_app/app.dart';

void main() {
  testWidgets('home screen loads feature cards', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: LoveCosmosApp()));
    await tester.pumpAndSettle();

    expect(find.text('Love Interest Analyzer'), findsOneWidget);
    expect(find.text('Zodiac Compatibility'), findsOneWidget);
    expect(find.text('Saju Five Elements'), findsOneWidget);
  });
}
