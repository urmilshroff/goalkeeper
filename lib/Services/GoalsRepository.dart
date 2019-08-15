import 'package:flutter/cupertino.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/Interfaces/ICache.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';

import 'Interfaces/IDatabase.dart';

class GoalsRepository implements IRepository, ICache<Goal> {
  List<Goal> _cache = new List<Goal>();
  IDatabase database;
  GoalsRepository({@required this.database});

  bool shouldSyncCache = true;

  Future<void> syncCache() async {
    if (_cache.isNotEmpty) _cache.clear();
    var goalsList = await database.getGoalsList();
    _cache.addAll(goalsList);
    shouldSyncCache = false;
  }

  int getGoalsCount() => _cache.length;

  Future<List<Goal>> getGoalsList() async {
    if (shouldSyncCache) {
      await syncCache();
    }
    return _cache;
  }

  void insert(Goal goal) {
    if (goal.id == null) goal.id = this.getNextId();
    database.createGoal(goal);
    _cache.add(goal);
  }

  void delete(Goal goal) {
    database.deleteGoal(goal);
    _cache.removeWhere((Goal _goal) => _goal.id == goal.id);
  }

  void update(Goal goal) {
    database.updateGoal(goal);
    var itemIndex = _cache.indexWhere((Goal _g) => _g.id == goal.id);
    if (itemIndex == -1) return;

    if (_cache.length == 1) {
      _cache.clear();
      _cache.add(goal);
    } else {
      _cache.replaceRange(itemIndex, itemIndex + 1, [goal]);
    }
  }

  int getNextId() {
    // since the id is auto-generated in predictable way, we can read the future ! :D
    return _cache.isNotEmpty ? _cache.last.id + 1 : 1;
  }

  Goal find(int goalId) {
    return _cache.firstWhere((Goal goal) => goal.id == goalId,
        orElse: () => null);
  }
}
