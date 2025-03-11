### Documentación Extensa del Código: Contador de Palabras Detallado en Flutter

Este documento explica en detalle el funcionamiento del código de una aplicación Flutter que cuenta palabras de un texto ingresado por el usuario. La aplicación no solo cuenta las palabras, sino que también proporciona información adicional, como el número total de palabras, la palabra más frecuente y la menos frecuente.

---

### Estructura del Código

El código está organizado en las siguientes partes principales:

1. **Función `main`**: Punto de entrada de la aplicación.
2. **Clase `MyApp`**: Configura la aplicación y define el tema.
3. **Clase `WordCounter`**: Contiene la lógica principal de la aplicación y la interfaz de usuario.
4. **Método `_countWords`**: Realiza el conteo de palabras y actualiza el estado de la aplicación.

---

### Explicación Detallada

#### 1. **Función `main`**
```dart
void main() {
  runApp(MyApp());
}
```
- **Propósito**: Es el punto de entrada de la aplicación Flutter.
- **Funcionalidad**: Llama a `runApp` para iniciar la aplicación, pasando una instancia de `MyApp` como widget raíz.

---

#### 2. **Clase `MyApp`**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WordCounter(),
    );
  }
}
```
- **Propósito**: Configura la aplicación y define el tema visual.
- **Funcionalidad**:
  - `title`: Define el título de la aplicación.
  - `theme`: Establece el tema de la aplicación usando `ThemeData`. En este caso, se usa el color azul como color principal.
  - `home`: Define la pantalla principal de la aplicación, que es una instancia de `WordCounter`.

---

#### 3. **Clase `WordCounter`**
```dart
class WordCounter extends StatefulWidget {
  @override
  _WordCounterState createState() => _WordCounterState();
}
```
- **Propósito**: Define un widget con estado (`StatefulWidget`) que gestiona la lógica y la interfaz de usuario de la aplicación.
- **Funcionalidad**:
  - `createState`: Crea una instancia de `_WordCounterState`, que contiene la lógica y la interfaz de usuario.

---

#### 4. **Clase `_WordCounterState`**
```dart
class _WordCounterState extends State<WordCounter> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, int>> _wordCounts = [];
  int _totalWords = 0;
  String _mostFrequentWord = '';
  String _leastFrequentWord = '';
  int _mostFrequentCount = 0;
  int _leastFrequentCount = 0;
```
- **Propósito**: Gestiona el estado de la aplicación y contiene la lógica para contar palabras.
- **Variables**:
  - `_textController`: Controlador para el campo de texto (`TextField`) donde el usuario ingresa el párrafo.
  - `_wordCounts`: Lista que almacena el conteo de cada palabra en forma de mapas (`Map<String, int>`).
  - `_totalWords`: Almacena el número total de palabras en el texto.
  - `_mostFrequentWord` y `_mostFrequentCount`: Almacenan la palabra más frecuente y su conteo.
  - `_leastFrequentWord` y `_leastFrequentCount`: Almacenan la palabra menos frecuente y su conteo.

---

#### 5. **Método `_countWords`**
```dart
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
```
- **Propósito**: Realiza el conteo de palabras y actualiza el estado de la aplicación.
- **Funcionalidad**:
  1. **Normalización del texto**:
     - Convierte el texto a minúsculas (`toLowerCase()`).
     - Elimina caracteres especiales usando una expresión regular (`RegExp(r'[^\w\s]')`).
  2. **División del texto en palabras**:
     - Usa `split(RegExp(r'\s+'))` para dividir el texto en palabras basadas en espacios.
  3. **Conteo de palabras**:
     - Itera sobre la lista de palabras y cuenta cuántas veces aparece cada una, almacenando el resultado en un mapa (`wordCountMap`).
  4. **Ordenación y actualización del estado**:
     - Ordena las palabras por frecuencia (de mayor a menor).
     - Actualiza el estado con los resultados usando `setState`.

---

#### 6. **Método `build`**
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Contador de Palabras Detallado')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Ingrese un párrafo',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _countWords,
            child: Text('Contar Palabras'),
          ),
          SizedBox(height: 20),
          Text('Total de palabras: $_totalWords'),
          Text(
            'Palabra más frecuente: $_mostFrequentWord ($_mostFrequentCount veces)',
          ),
          Text(
            'Palabra menos frecuente: $_leastFrequentWord ($_leastFrequentCount veces)',
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _wordCounts.length,
              itemBuilder: (context, index) {
                var entry = _wordCounts[index];
                var word = entry.keys.first;
                var count = entry[word];
                return ListTile(title: Text(word), trailing: Text('$count'));
              },
            ),
          ),
        ],
      ),
    ),
  );
}
```
- **Propósito**: Construye la interfaz de usuario de la aplicación.
- **Componentes**:
  1. **AppBar**: Muestra el título de la aplicación.
  2. **TextField**: Permite al usuario ingresar un párrafo.
  3. **ElevatedButton**: Botón que ejecuta el conteo de palabras al ser presionado.
  4. **Text**: Muestra el total de palabras, la palabra más frecuente y la menos frecuente.
  5. **ListView.builder**: Muestra una lista de palabras con su conteo.

---

### Resumen de Funcionalidades

1. **Ingreso de texto**: El usuario puede ingresar un párrafo en un campo de texto.
2. **Conteo de palabras**: Al presionar el botón, la aplicación cuenta las palabras, ignorando mayúsculas, tildes y caracteres especiales.
3. **Información detallada**:
   - Número total de palabras.
   - Palabra más frecuente y su conteo.
   - Palabra menos frecuente y su conteo.
4. **Lista de palabras**: Muestra todas las palabras con su frecuencia en una lista ordenada.

---

### Ejecución

Para ejecutar la aplicación:
1. Guarda el código en `lib/main.dart`.
2. Ejecuta `flutter run` en la terminal.
3. Ingresa un párrafo en el campo de texto y presiona "Contar Palabras" para ver los resultados.

---
