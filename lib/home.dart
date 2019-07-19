import 'package:flutter/material.dart';
import 'package:tryouts/example_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> examples = exampleData;

  void _navigateToView(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
     title: Text(examples[index]['displayText']), 
     onTap: () {
       _navigateToView(context, examples[index]['page']);
     },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Try Outs'),
      ),
      body: ListView.builder(
        itemCount: examples.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, index);
        },
      ),
    );
  }
}
