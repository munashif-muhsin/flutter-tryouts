import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class DragDropPage extends StatefulWidget {
  @override
  _DragDropPageState createState() => _DragDropPageState();
}

class _DragDropPageState extends State<DragDropPage> {
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    '🍏': Colors.green,
    '🍋': Colors.yellow,
    '🍅': Colors.red,
    '🍇': Colors.purple,
    '🥥': Colors.brown,
    '🥕': Colors.orange
  };

  int seed = 0;

  AudioCache _audioCache = AudioCache();

  Widget _buildDropZone(String choice) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[choice] == true) {
          return Container(
            width: MediaQuery.of(context).size.width - 130,
            color: Colors.white.withOpacity(0),
            child: Text(
              'Correct',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'PressStart', fontSize: 16.0),
            ),
            alignment: Alignment.center,
            height: 100,
          );
        } else {
          return Container(
            color: choices[choice],
            height: 100,
            width: MediaQuery.of(context).size.width - 130,
            margin: EdgeInsets.only(left: 20),
          );
        }
      },
      onWillAccept: (data) => data == choice,
      onAccept: (data) {
        setState(() => score[choice] = true);
        _audioCache.play("music/game_boy_switch_on.mp3");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Score ${score.length} / 6',
          style: TextStyle(fontFamily: 'PressStart', fontSize: 16.0),
        ),
      ),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: choices.keys.map((emoji) {
              return Draggable<String>(
                data: emoji,
                child: Emoji(emoji),
                feedback: Emoji(emoji, true),
                childWhenDragging: _buildCancelWidget(),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                choices.keys.map((emoji) => _buildDropZone(emoji)).toList()
                  ..shuffle(Random(seed)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => setState(() {
          score.clear();
          seed++;
        }),
      ),
    );
  }
}

Widget _buildCancelWidget() {
  return Container(
    alignment: Alignment.center,
    height: 100.0,
    width: 100.0,
    child: Icon(Icons.cancel),
  );
}

class Emoji extends StatelessWidget {
  final String emoji;
  final bool isDragged;
  Emoji(this.emoji, [this.isDragged = false]);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0),
      child: Container(
        alignment: Alignment.center,
        height: 100.0,
        width: 100.0,
        child: Text(
          emoji,
          style: TextStyle(fontSize: isDragged ? 80.0 : 50.0),
        ),
      ),
    );
  }
}
