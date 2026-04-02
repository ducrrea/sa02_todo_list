// situação de aprendizagem 02 -  aplicativo todo-list

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoListView(),
  ));
}

// a classe da Janela Stateful
// 1º classe: identifica ass mudanças de estado e chama o rebuild da tela 
class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  //atributos
  //obbj para controlar os dados do input
  //final => permite a mudança de valor uma unica vez
  // o uso do _ transfoma a variavel em private
  final TextEditingController _tarefasController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = [];
  
  //metodos


  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas"),centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(8),
      child: Column(
        children: [
          //add mais de um elemento
          TextField(
            controller: _tarefasController,
            decoration: InputDecoration(
              labelText: "Digite uma tarefa..."
            ),
          ),
          //espaçamento
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: _adicionarTarefa, 
            child: Text("Adicionar tarefa")),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) => 
                  //para cada elemento faça (FOREACH)
                  ListTile(
                    title: Text(_tarefas[index]["titulo"], style: TextStyle(
                      decoration: _tarefas[index]["concluida"]? TextDecoration.lineThrough :null
                    ),),
                    //add um checkbox antes do texto
                    leading: Checkbox(
                      value: _tarefas[index]["concluida"], 
                      onChanged: (bool? valor) => setState(() {
                        _tarefas[index]["concluida"] = valor!;
                      })),
                      trailing: IconButton(
                        onPressed: () => _deletarTarefa(index), 
                        icon: Icon(Icons.delete)),
                  )))
        ],
      ),),
    );
  }

  void _adicionarTarefa() {
    if(_tarefasController.text.trim().isNotEmpty){
      setState(() {
        _tarefas.add({"titulo":_tarefasController.text.trim(), "concluida": false});
      });
    }
  }

  void _deletarTarefa(int index){
    if (_tarefas[index]["concluida"] == true) {
      setState(() {
        _tarefas.removeAt(index);
      });
    }
  }
}