import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TemperaturaApp(),
  ));
}

class TemperaturaApp extends StatefulWidget {
  @override
  _TemperaturaAppState createState() => _TemperaturaAppState();
}

class _TemperaturaAppState extends State<TemperaturaApp> {
  int temperatura = 20;
  
  // Variáveis para interface dinâmica
  Color corFundo = Colors.green;
  IconData icone = Icons.wb_sunny;
  String status = "Agradável";

  // Função Aumentar
  void aumentar() {
    setState(() {
      temperatura++;
      atualizarInterface();
    });
  }

  // Função Diminuir
  void diminuir() {
    setState(() {
      temperatura--;
      atualizarInterface();
    });
  }

  // Lógica de Temperatura
  void atualizarInterface() {
    if (temperatura < 20) {
      corFundo = Colors.blue;
      icone = Icons.ac_unit;
      status = "Frio";
    } else if (temperatura < 30) {
      corFundo = Colors.green;
      icone = Icons.wb_sunny;
      status = "Agradável";
    } else {
      corFundo = Colors.red;
      icone = Icons.local_fire_department;
      status = "Quente";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: Text("Controle de Temperatura"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone
            Icon(
              icone,
              size: 100,
              color: Colors.white,
            ),
            
            // Status
            Text(
              status,
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            
            SizedBox(height: 20),
            
            // Temperatura
            Text(
              "$temperatura °C",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            
            SizedBox(height: 20),
            
            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: diminuir,
                  child: Text("-", style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 60),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: aumentar,
                  child: Text("+", style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 60),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}