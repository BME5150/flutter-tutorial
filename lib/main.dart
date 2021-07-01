import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp()); /*1*/

class MyApp extends StatelessWidget {/*2*/
  @override
  // Widget: UI部品。コンポーネント的なもの
  // 動的に再レンダリングできるstatefulと、
  // 状態の変更による更新を行わないstatelessを
  // 用途に合わせて継承して使う
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        home: RandomWords()
    );
  }}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // final: dartでは定数的な変数の宣言を指す。コンパイル時評価はされない
  // const: コンパイル時評価される定数的な変数。宣言されている別の変数を代入するとエラー
  // 変数名の頭にアンダースコアでprivate変数になる
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]); /*5*/
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
    