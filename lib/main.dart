import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Palabras Detallado',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordCounter(),
    );
  }
}

class WordCounter extends StatefulWidget {
  @override
  _WordCounterState createState() => _WordCounterState();
}

class _WordCounterState extends State<WordCounter> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, int>> _wordCounts = [];
  int _totalWords = 0;
  String _mostFrequentWord = '';
  String _leastFrequentWord = '';
  int _mostFrequentCount = 0;
  int _leastFrequentCount = 0;

  void _countWords() {
    String text = _textController.text.toLowerCase();
    text = text.replaceAll(RegExp(r'[^\w\s]'), ''); // Elimina caracteres especiales
    List<String> words = text.split(RegExp(r'\s+')); // Divide el texto en palabras

    Map<String, int> wordCountMap = {};
    for (String word in words) {
      if (word.isNotEmpty) {
        wordCountMap[word] = (wordCountMap[word] ?? 0) + 1;
      }
    }

    if (wordCountMap.isNotEmpty) {
      var sortedEntries = wordCountMap.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      setState(() {
        _wordCounts = sortedEntries.map((entry) => {entry.key: entry.value}).toList();
        _totalWords = words.length;
        _mostFrequentWord = sortedEntries.first.key;
        _mostFrequentCount = sortedEntries.first.value;
        _leastFrequentWord = sortedEntries.last.key;
        _leastFrequentCount = sortedEntries.last.value;
      });
    } else {
      setState(() {
        _wordCounts = [];
        _totalWords = 0;
        _mostFrequentWord = '';
        _mostFrequentCount = 0;
        _leastFrequentWord = '';
        _leastFrequentCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de Palabras Detallado'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para ingresar el párrafo
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Ingrese un párrafo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Escribe aquí...',
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Botón para contar palabras
            ElevatedButton(
              onPressed: _countWords,
              child: Text(
                'Contar Palabras',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Información detallada
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total de palabras: $_totalWords',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Palabra más frecuente: $_mostFrequentWord ($_mostFrequentCount veces)',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Palabra menos frecuente: $_leastFrequentWord ($_leastFrequentCount veces)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Lista de palabras con su conteo
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conteo de palabras',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _wordCounts.length,
                          itemBuilder: (context, index) {
                            var entry = _wordCounts[index];
                            var word = entry.keys.first;
                            var count = entry[word];
                            return ListTile(
                              title: Text(
                                word,
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: Text(
                                '$count',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
