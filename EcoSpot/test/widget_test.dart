import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:eco/main.dart';
import 'package:eco/user_login_screen.dart';

void main() {
  testWidgets('MyApp shows LoginPage initially', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

