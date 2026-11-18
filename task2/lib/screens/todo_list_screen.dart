import 'package:flutter/material.dart';

import 'add_todo_screen.dart';
import '../models/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Lista delle attività in memoria
  final List<Todo> _todos = [];
  // Conta quante attività hanno isCompleted == true (metodi List da L5)
  int get _completedCount => _todos.where((t) => t.isCompleted).length;

  Future<void> _eliminaAttivita(int index) async {
    final confermato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Elimina attività'),
        content: Text('Vuoi eliminare "${_todos[index].title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
    //Variante rinuncia
    if (confermato != true) return;

    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Le mie attività')),
      body: Column(
        children: [
          // Riga del conteggio (Scenario S2)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Completate: $_completedCount su ${_todos.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Expanded fa occupare alla lista tutto lo spazio rimanente (vedi Lez6 slide 7)
          Expanded(
            // UI condizionale (vedi Lez6 slide 13): lista vuota vs ListView.builder
            child: _todos.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Nessuna attività presente.\nPremi + in basso per aggiungerne una.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : ListView.builder(
                    // L6 slide 8
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return ListTile(title: Text(todo.title));
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Apre AddTodoScreen e attende il risultato
          final risultato = await Navigator.push<Todo>(
            context,
            MaterialPageRoute(builder: (_) => const AddTodoScreen()),
          );
          //Se la schermata è stata chiusa o risultato == null non fare nulla
          if (!context.mounted || risultato == null) return;
          //altrimenti aggiungi l'attività in lista e aggiorna
          setState(() {
            _todos.add(risultato);
          });
          //Mostra il mess di conferma
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Attività ${risultato.title} aggiunta')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
