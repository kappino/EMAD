import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenStare();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Lista delle attività in memoria
  final List<Todo> _todos = [];
  // Conta quante attività hanno isCompleted == true (metodi List da L5)
  int get _completedCount => _todos.where((t) => t.isCompleted).length;
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
