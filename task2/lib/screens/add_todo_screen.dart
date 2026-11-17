import 'package:flutter/material.dart';

import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  //Scenario S1 - Aggiunta nuova attivitò
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  // Controller per leggere il testo in TextField
  final _titleController = TextEditingController();

  bool _isImportant = false;
  bool _showError = false;

  @override
  void dispose() {
    //Pulisce le risorse del controller quando si chiude la schermata
    _titleController.dispose();
    super.dispose();
  }

  void _conferma() {
    final titolo = _titleController.text.trim();

    //Se il titolo è mancante segnaliamo l'errore e non creaiamo l'attività
    if (titolo.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    // Crea l'oggetto Todo e lo restituisce alla schermata precedente
    final nuovaAttivita = Todo(title: titolo, isImportant: _isImportant);
    Navigator.pop(context, nuovaAttivita);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Aggiunge automaticamente la freccia indietro per l'abort
        title: const Text('Nuova attività'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Titolo',
                errorText: _showError ? 'Inserisci un titolo' : null,
              ),
              //Quando l'utente corregge il titolo l'errore scompare
              onChanged: (value) {
                if (_showError && value.trim().isNotEmpty) {
                  setState(() {
                    _showError = false;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            //riga orizzontale con testo e switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Importante', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _isImportant,
                  onChanged: (valore) => setState(() {
                    _isImportant = valore;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _conferma, child: const Text('Aggiungi')),
          ],
        ),
      ),
    );
  }
}
