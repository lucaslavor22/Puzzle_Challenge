import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() {
  runApp(const PuzzleGame());
}

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const PuzzleHomePage(),
    );
  }
}

class PuzzleHomePage extends StatefulWidget {
  const PuzzleHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PuzzleHomePageState createState() => _PuzzleHomePageState();
}

class _PuzzleHomePageState extends State<PuzzleHomePage> {
  List<int> tiles = List<int>.generate(15, (index) => index + 1)..add(0); 
  int moves = 0;
  
  get bold => null;

  void moveTile(int index) {
    int emptyIndex = tiles.indexOf(0);
    int row = index ~/ 4;
    int col = index % 4;
    int emptyRow = emptyIndex ~/ 4;
    int emptyCol = emptyIndex % 4;

    if ((row - emptyRow).abs() + (col - emptyCol).abs() == 1) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
        moves++;
      });
    }
  }

  void showRestartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reiniciar"),
          content: const Text("Você quer reiniciar?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sim"),
              onPressed: () {
                setState(() {
                  tiles = List<int>.generate(15, (index) => index + 1)..add(0); 
                  moves = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            SystemNavigator.pop(); 
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Puzzle Challenge",
              style: TextStyle(fontSize: 30, fontFamily: bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    "Moves: $moves | Tiles: 15",
                    style: const TextStyle(fontSize: 25, color: Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        moveTile(index);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(1),
                        color: tiles[index] == 0 ? Colors.transparent : Colors.blue,
                        child: Center(
                          child: Text(
                            tiles[index] == 0 ? '' : tiles[index].toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tiles.shuffle(); 
                      moves = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                  ),
                  child: const Text(
                    'Shuffle',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: showRestartDialog,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
