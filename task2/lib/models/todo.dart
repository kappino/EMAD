/// Modello che rappresenta una singola attività della To-Do List.
class Todo {
  // Titolo descrittivo dell'attività (non può essere null).
  String title;

  // Stato dell'attività: false = "da fare", true = "completata".
  // Non è final perché l'utente può cambiarlo in qualsiasi momento (Scenario S3).
  bool isCompleted;

  // Indica se l'attività è contrassegnata come importante (true) oppure no (false).
  bool isImportant;

  /// Costruttore con parametri nominali (tra parentesi graffe { }).
  Todo({
    // 'required' obbliga a passare sempre il titolo quando si crea una nuova attività.
    required this.title,

    // Valori di default: se non specificati, una nuova attività parte "da fare" e non importante.
    this.isCompleted = false,
    this.isImportant = false,
  });
}
