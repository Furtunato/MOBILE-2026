import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JogoApp(),
  ));
}

class JogoApp extends StatefulWidget {
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {
  // Variáveis
  IconData iconeComputador = Icons.help_outline;
  String resultado = "Escolha uma opção";
  int pontosJogador = 0;
  int pontosComputador = 0;
  List<String> opcoes = ["pedra", "papel", "tesoura"];

  // Função Jogar
  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3);
    var escolhaComputador = opcoes[numero];
    
    setState(() {
      // Mostrar Escolha do Computador
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape;
      } else if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      } else if (escolhaComputador == "tesoura") {
        iconeComputador = Icons.content_cut;
      }
      
      // Lógica do Jogo
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate";
      } else if (
        (escolhaUsuario == "pedra" && escolhaComputador == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaComputador == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu!";
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";
      }
      
      // Campeonato com 5 Pontos
      if (pontosJogador >= 5) {
        resultado = "🎉 VOCÊ GANHOU O CAMPEONATO! 🎉";
        pontosJogador = 0;
        pontosComputador = 0;
      } else if (pontosComputador >= 5) {
        resultado = "💻 COMPUTADOR GANHOU O CAMPEONATO! 💻";
        pontosJogador = 0;
        pontosComputador = 0;
      }
    });
  }

  // Função Resetar Placar
  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      resultado = "Placar resetado!";
      iconeComputador = Icons.help_outline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedra Papel Tesoura"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.blue[300]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Texto "Computador"
              Text(
                "Computador",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              // Ícone do Computador
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  iconeComputador,
                  size: 80,
                  color: Colors.blue[800],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Resultado
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  resultado,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Placar
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  "Você: $pontosJogador  |  PC: $pontosComputador",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
              
              SizedBox(height: 40),
              
              // Texto "Sua vez"
              Text(
                "Sua vez:",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              
              SizedBox(height: 10),
              
              // Botões de Escolha
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botão Pedra
                  _buildEscolhaButton(
                    icon: Icons.landscape,
                    cor: Colors.grey,
                    onTap: () => jogar("pedra"),
                    label: "Pedra",
                  ),
                  
                  SizedBox(width: 20),
                  
                  // Botão Papel
                  _buildEscolhaButton(
                    icon: Icons.pan_tool,
                    cor: Colors.blue,
                    onTap: () => jogar("papel"),
                    label: "Papel",
                  ),
                  
                  SizedBox(width: 20),
                  
                  // Botão Tesoura
                  _buildEscolhaButton(
                    icon: Icons.content_cut,
                    cor: Colors.red,
                    onTap: () => jogar("tesoura"),
                    label: "Tesoura",
                  ),
                ],
              ),
              
              SizedBox(height: 40),
              
              // Botão Resetar Placar
              ElevatedButton.icon(
                onPressed: resetarPlacar,
                icon: Icon(Icons.refresh),
                label: Text("Resetar Placar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar botões de escolha
  Widget _buildEscolhaButton({
    required IconData icon,
    required Color cor,
    required VoidCallback onTap,
    required String label,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: cor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}