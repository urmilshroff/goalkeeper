import 'package:flutter_test/flutter_test.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/GoalsRepository.dart';
import 'package:mockito/mockito.dart';

import 'Mocks/MockDb.dart';

void main() {
  test('repo is singleton', () {
    var cache = GoalsRepository();
    var anotherCache = GoalsRepository();
    expect(cache, same(anotherCache));
  });

  test('repo initialize correctly from Db', () {
    final mockDb = MockDb();
    final Goal testGoal = Goal('test_title_goal', 'test_body_goal');

    when(mockDb.getGoalsList()).thenAnswer((_) async => [testGoal]);

    expect(GoalsRepository().getGoalsList(), contains(testGoal));
  });

  test('repo pruges correctly', () {});
}
