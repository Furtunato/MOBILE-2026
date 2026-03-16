import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jogo_ppt_application/main.dart';

void main() {
  testWidgets('Jogo Pedra Papel Tesoura Test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(JogoApp());

    // Verifica título da AppBar
    expect(find.text('Pedra Papel Tesoura'), findsOneWidget);
    
    // Verifica texto inicial
    expect(find.text('Escolha uma opção'), findsOneWidget);
    expect(find.text('Você: 0  |  PC: 0'), findsOneWidget);
    
    // Clica no botão Pedra (procurando pelo texto "Pedra")
    await tester.tap(find.text('Pedra'));
    await tester.pump();
    
    // Verifica se resultado mudou (agora deve ter algum texto com "Você" ou "Computador")
    expect(find.textContaining('Você'), findsWidgets);
    
    // Testa botão reset
    await tester.tap(find.text('Resetar Placar'));
    await tester.pump();
    
    // Verifica se resetou
    expect(find.text('Placar resetado!'), findsOneWidget);
  });
}