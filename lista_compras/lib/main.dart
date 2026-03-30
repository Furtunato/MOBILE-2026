import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaComprasApp(),
  ));
}

class ListaComprasApp extends StatefulWidget {
  @override
  _ListaComprasAppState createState() => _ListaComprasAppState();
}

class _ListaComprasAppState extends State<ListaComprasApp> {
  List<String> itens = [];
  List<bool> comprado = [];
  TextEditingController controller = TextEditingController();

  // PASSO 1 – Adicionar item
  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        comprado.add(false);
        controller.clear();
      });
      salvarDados();
    }
  }

  // PASSO 2 – Alternar comprado
  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index];
    });
    salvarDados();
  }

  // Remover item
  void removerItem(int index) {
    setState(() {
      itens.removeAt(index);
      comprado.removeAt(index);
    });
    salvarDados();
  }

  // DESAFIO EXTRA – Limpar lista
  void limparLista() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar"),
          content: Text("Tem certeza que deseja limpar toda a lista?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  itens.clear();
                  comprado.clear();
                });
                salvarDados();
                Navigator.pop(context);
              },
              child: Text("Limpar"),
            ),
          ],
        );
      },
    );
  }

  // PASSO 3 – Salvar dados
  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("itens", itens);
    prefs.setStringList(
      "comprado",
      comprado.map((e) => e.toString()).toList(),
    );
  }

  // PASSO 4 – Carregar dados
  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      itens = prefs.getStringList("itens") ?? [];
      List<String> listaBool = prefs.getStringList("comprado") ?? [];
      comprado = listaBool.map((e) => e == "true").toList();
      
      // Garante que as listas tenham o mesmo tamanho
      if (itens.length != comprado.length) {
        comprado = List<bool>.filled(itens.length, false);
      }
    });
  }

  // DESAFIO EXTRA – Contador de itens
  String get contadorItens {
    int total = itens.length;
    int comprados = comprado.where((c) => c == true).length;
    return "$comprados/$total itens comprados";
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras Inteligente"),
        backgroundColor: Colors.green,
        actions: [
          // DESAFIO EXTRA – Botão limpar lista
          if (itens.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: limparLista,
              tooltip: "Limpar lista",
            ),
        ],
      ),
      body: Column(
        children: [
          // DESAFIO EXTRA – Contador de itens
          if (itens.isNotEmpty)
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.green.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    contadorItens,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  if (comprados > 0)
                    Text(
                      "✅ ${comprados} comprado(s)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                      ),
                    ),
                ],
              ),
            ),
          
          // Campo para adicionar itens
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Digite um item",
                      hintText: "Ex: Arroz, Leite, Café...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.shopping_cart),
                    ),
                    onSubmitted: (value) => adicionarItem(),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: adicionarItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Adicionar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          
          // Lista de itens
          Expanded(
            child: itens.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Sua lista está vazia",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          "Adicione itens para começar!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: Checkbox(
                            value: comprado[index],
                            onChanged: (value) => alternarComprado(index),
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                          ),
                          title: Text(
                            itens[index],
                            style: TextStyle(
                              // DESAFIO VISUAL – Item riscado se comprado
                              decoration: comprado[index]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              // DESAFIO EXTRA – Cor diferente quando comprado
                              color: comprado[index]
                                  ? Colors.grey.shade500
                                  : Colors.black87,
                              fontSize: 16,
                              fontWeight: comprado[index]
                                  ? FontWeight.normal
                                  : FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade300,
                            ),
                            onPressed: () => removerItem(index),
                            tooltip: "Remover item",
                          ),
                          onTap: () => alternarComprado(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // DESAFIO EXTRA – Botão flutuante com resumo
      floatingActionButton: itens.isNotEmpty && comprados < itens.length
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Resumo da Lista"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("📝 Total de itens: ${itens.length}"),
                          SizedBox(height: 8),
                          Text("✅ Itens comprados: $comprados"),
                          SizedBox(height: 8),
                          Text("⏳ Restam: ${itens.length - comprados}"),
                          SizedBox(height: 16),
                          if (comprados < itens.length)
                            Text(
                              "Faltam comprar:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ...itens.asMap().entries
                              .where((entry) => !comprado[entry.key])
                              .map((entry) => Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Text("• ${entry.value}"),
                                  ))
                              .toList(),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Fechar"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.summarize),
              label: Text("Resumo"),
              backgroundColor: Colors.green,
            )
          : null,
    );
  }

  int get comprados => comprado.where((c) => c == true).length;
}