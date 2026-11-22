import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_sudoku_cesit_paketi/oyun_sudoku_cesit_paketi.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('30 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(sudokuPaketConfigs.length, 30);
    expect(sudokuPaketConfigs.map((c) => c.gameId).toSet().length, 30);
    expect(sudokuPaketGroup.title.length, 33);
    expect(sudokuPaketGroup.tagline.length, 33);
    for (final c in sudokuPaketConfigs) {
      expect(c.title.length, 33);
      expect(c.tagline.length, 33);
      for (final s in c.tutorial) {
        expect(s.text.length, 33);
      }
    }
  });

  for (final rules in sudokuPaketRules) {
    test('${rules.gameId}: bölümler üretilir ve doğrulanır', () {
      final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: const []);
      for (final lv in [1, 54321]) {
        final gl = rules.build(planner.spec(lv));
        expect(gl.validation.ok, isTrue, reason: '${rules.gameId} $lv');
        final k = rules.kindForLevel(gl.spec.difficulty);
        final start = k.initial(gl.puzzle);
        expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      }
    });
  }
}
