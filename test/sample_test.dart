import 'package:flutter_test/flutter_test.dart';

class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
}

void main() {
  group('Calculator', () {
    final calculator = Calculator();

    test('adds two numbers correctly', () {
      expect(calculator.add(2, 3), 5);
    });

    test('subtracts two numbers correctly', () {
      expect(calculator.subtract(5, 3), 2);
    });
  });
}
