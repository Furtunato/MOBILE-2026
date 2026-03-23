import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ListaContatos()));
}

// Tela 1 – Lista de Contatos

class ListaContatos extends StatelessWidget {
  final List<Map<String, String>> contatos = [
    {"nome": "João", "telefone": "1199999-1111"},
    {"nome": "Maria", "telefone": "1199999-2222"},
    {"nome": "Carlos", "telefone": "1199999-3333"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];

          return ListTile(
            leading: Icon(Icons.person),
            title: Text(contato["nome"]!),
            subtitle: Text(contato["telefone"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheContato(
                    nome: contato["nome"]!,
                    telefone: contato["telefone"]!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Tela 2 – Detalhes

class DetalheContato extends StatelessWidget {
  final String nome;
  final String telefone;

  const DetalheContato({
    Key? key,
    required this.nome,
    required this.telefone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nome: $nome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Telefone: $telefone",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}