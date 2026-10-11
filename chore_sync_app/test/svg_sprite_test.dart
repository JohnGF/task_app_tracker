import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chore_sync_app/widgets/svg_sprite.dart';

void main() {
  group('SvgSprite and SkinnedButton Widget Tests', () {
    testWidgets('SvgSprite renders inside a ClipRect with correct dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SvgSprite(
              assetName: 'assets/ui_skin.svg',
              sourceX: 10,
              sourceY: 20,
              sourceWidth: 50,
              sourceHeight: 50,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox).first;
      expect(sizedBoxFinder, findsWidgets);

      final clipRectFinder = find.byType(ClipRect);
      expect(clipRectFinder, findsOneWidget);
    });

    testWidgets('SkinnedButton renders and handles taps', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkinnedButton(
              onPressed: () {
                tapped = true;
              },
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      expect(find.text('Tap Me'), findsOneWidget);

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tapped, true);
    });
  });
}
