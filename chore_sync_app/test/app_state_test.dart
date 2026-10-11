import 'package:flutter_test/flutter_test.dart';
import 'package:chore_sync_app/providers/app_state.dart';

void main() {
  group('AppState Tests', () {
    test('Initial state is correct', () {
      final appState = AppState();
      expect(appState.role, 'kid');
      expect(appState.points, 0);
    });

    test('setRole changes the role', () {
      final appState = AppState();
      appState.setRole('adult');
      expect(appState.role, 'adult');
    });

    test('addPoints increases points', () {
      final appState = AppState();
      appState.addPoints(50);
      expect(appState.points, 50);
      appState.addPoints(25);
      expect(appState.points, 75);
    });

    test('spendPoints decreases points if sufficient', () {
      final appState = AppState();
      appState.addPoints(100);
      appState.spendPoints(40);
      expect(appState.points, 60);
    });

    test('spendPoints does not decrease points if insufficient', () {
      final appState = AppState();
      appState.addPoints(50);
      appState.spendPoints(100);
      expect(appState.points, 50);
    });
  });
}
