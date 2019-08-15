import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/Interfaces/IDatabase.dart';
import 'package:mockito/mockito.dart';

import '../Mocks/MockDb.dart';

IDatabase getMockDb({List<Goal> goals}) {
  var mockDb = MockDb();
  when(mockDb.getGoalsList()).thenAnswer((_) async => List<Goal>());
  return mockDb;
}
