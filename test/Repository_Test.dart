import 'package:flutter_test/flutter_test.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/GoalsRepository.dart';
import 'package:goalkeeper/Services/Interfaces/IDatabase.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:mockito/mockito.dart';
import 'Utils/MockFactory.dart';

void main() {
  IRepository repository;
  IDatabase db;
  final Goal goal = Goal('test_title_2', 'test_body_2');

  setUp(() {
    db = getMockDb();
    repository = GoalsRepository(database: db);
  });

  test('repo initializes correctly from Db', () async {
    await repository.getGoalsList();

    verify(db.getGoalsList()).called(1);
  });

  test('repo adds successfully', () async {
    repository.insert(goal);

    verify(db.createGoal(goal)).called(1);
    expect(repository.getGoalsCount(), equals(1));
    expect(repository.find(goal.id), equals(goal));
  });

  test('repo deletes successfully', () {
    repository.insert(goal);

    repository.delete(goal);
    verify(db.deleteGoal(goal)).called(1);
    expect(repository.getGoalsCount(), equals(0));
  });

  test('repo updates successfully when there is one element', () {
    repository.insert(goal);
    goal.title = 'new_title';
    goal.body = 'new_body';

    repository.update(goal);

    verify(db.updateGoal(goal)).called(1);
    expect(repository.find(goal.id), equals(goal));
  });

  group('nextId', () {
    test('should return 1 initially', () {
      expect(repository.getNextId(), equals(1));
    });

    test('gets incremented on insertion', () {
      repository.insert(goal);
      expect(repository.getNextId(), equals(2));
    });

    test('does not change when updating existing goal', () {
      repository.insert(goal);

      repository.update(goal);
      expect(repository.getNextId(), equals(2));
    });

    test('gets decremented when deleting last element', () {
      repository.insert(goal);

      repository.delete(goal);
      expect(repository.getNextId(), equals(1));
    });

    test('does not change when deleting any element except the last', () {
      repository.insert(goal);
      repository.insert(Goal("", ""));
      repository.insert(Goal("", ""));

      repository.delete(goal);

      expect(repository.getNextId(), equals(4));
    });
  });

  group('find', () {
    test('should return null if not found', () {
      expect(repository.find(1), isNull);
      repository.insert(goal);
      expect(repository.find(100), isNull);
    });

    test('should return goal if found', () {
      goal.id = 1;
      repository.insert(goal);
      expect(repository.find(goal.id), equals(goal));

      repository.delete(goal);
      expect(repository.find(goal.id), isNull);
    });
  });
}
