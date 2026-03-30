import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppNotas(),
  ));
}

class AppNotas extends StatefulWidget {
  @override
  _AppNotasState createState() => _AppNotasState();
}

class _AppNotasState extends State<AppNotas> {
  List<String> notas = [];
  TextEditingController controller = TextEditingController();

  // PASSO 2 – Função ADICIONAR
  void adicionarNota() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notas.add(controller.text);  // ✅ adiciona a nota
        controller.clear();          // ✅ limpa o campo
      });
      salvarNotas();
    }
  }

  // PASSO 3 – Função REMOVER
  void removerNota(int index) {
    setState(() {
      notas.removeAt(index);  // ✅ remove pelo índice
    });
    salvarNotas();
  }

  // PASSO 4 – Função SALVAR
  void salvarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("notas", notas);  // ✅ salva lista
  }

  // PASSO 5 – Função CARREGAR
  void carregarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notas = prefs.getStringList("notas") ?? [];  // ✅ carrega lista
    });
  }

  // PASSO 6 – initState
  @override
  void initState() {
    super.initState();
    carregarNotas();  // ✅ chama função que carrega os dados
  }

  // PASSO 7 – Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Notas")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Digite uma nota",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: adicionarNota,  // ✅ chama função adicionar
            child: Text("Salvar Nota"),
          ),
          Expanded(
            child: notas.isEmpty
                ? Center(child: Text("Nenhuma nota ainda"))
                : ListView.builder(
                    itemCount: notas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(notas[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removerNota(index),  // ✅ chama função remover
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}