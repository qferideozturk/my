import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart'; // Yol doğru olmalı

void main() {
  testWidgets('Giriş başarılı ve başarısız senaryoları', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    // Alanları bul
    final tcField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);
    final loginButton = find.byType(ElevatedButton);

    // Geçersiz giriş denemesi
    await tester.enterText(tcField, '00000000000');
    await tester.enterText(passwordField, 'yanlis');
    await tester.tap(loginButton);
    await tester.pump(); // snackbar beklemesi için

    expect(find.text('T.C. Kimlik No veya şifre yanlış!'), findsOneWidget);

    // Geçerli giriş
    await tester.enterText(tcField, '12345678901');
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Ana sayfa yüklendi mi?
    expect(find.text('e-Devlet Ana Sayfa'), findsOneWidget);
  });
}
