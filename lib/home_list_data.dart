import 'package:tryouts/pages/drag_drop/drag_drop.dart';
import 'package:tryouts/pages/giphy/giphy.dart';
import 'package:tryouts/pages/reflectly/reflectly.dart';
import 'package:tryouts/pages/skeleton_text/skeleton_text.dart';

List<Map<String, dynamic>> exampleData = [
  {
    'name': 'reflectly',
    'displayText': 'Reflectly Inspired Slideshow',
    'page': ReflectlyPage()
  },
  {
    'name': 'skeleton_text',
    'displayText': 'Skeleton Text Loading Animation',
    'page': SkeleTonText()
  },
  {
    'name': 'drag_drop',
    'displayText': 'Drag and Drop game',
    'page': DragDropPage()
  },
  {
    'name': 'Giphy Page',
    'displayText': 'Page bottom Navigation Bar',
    'page': GiphyPage()
  }
];
