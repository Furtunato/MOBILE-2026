import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperatura_application/main.dart';

void main() {
  testWidgets('Controle de Temperatura test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TemperaturaApp());

    // Verifica título da AppBar
    expect(find.text('Controle de Temperatura'), findsOneWidget);
    
    // Verifica temperatura inicial (20°C)
    expect(find.text('20 °C'), findsOneWidget);
    expect(find.text('Agradável'), findsOneWidget);
    
    // Clica no botão +
    await tester.tap(find.text('+'));
    await tester.pump();
    
    // Verifica se aumentou
    expect(find.text('21 °C'), findsOneWidget);
    
    // Clica no botão -
    await tester.tap(find.text('-'));
    await tester.pump();
    
    // Verifica se voltou para 20
    expect(find.text('20 °C'), findsOneWidget);
    
    // Testa temperatura fria
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('-'));
      await tester.pump();
    }
    expect(find.text('Frio'), findsOneWidget);
    
    // Testa temperatura quente
    for (int i = 0; i < 20; i++) {
      await tester.tap(find.text('+'));
      await tester.pump();
    }
    expect(find.text('Quente'), findsOneWidget);
  });
}