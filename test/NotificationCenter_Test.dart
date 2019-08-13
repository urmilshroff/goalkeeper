import 'package:flutter_test/flutter_test.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';

void main() {
  test('NotificationCenter is Singleton', () {
    final noty1 = NotificationCenter();
    final noty2 = NotificationCenter();
    expect(noty1, same(noty2));
  });
}
