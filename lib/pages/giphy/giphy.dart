import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class GiphyPage extends StatefulWidget {
  @override
  _GiphyPageState createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage> {
  List<MenuItem> items = [
    MenuItem(color: Colors.lightBlue[100], name: 'house', x: -1),
    MenuItem(color: Colors.purple, name: 'planet', x: -0.5),
    MenuItem(color: Colors.greenAccent, name: 'camera', x: 0),
    MenuItem(color: Colors.pink, name: 'heart', x: 0.5),
    MenuItem(color: Colors.yellow, name: 'head', x: 1),
  ];
  MenuItem active;

  Widget _buildFlareItem(MenuItem item) {
    return GestureDetector(
      onTap: () {
       setState(() {
          active = item;
       });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: FlareActor(
              'assets/flare/${item.name}.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: item.name == active.name ? 'go': 'idle',
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    active = items[0];
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(color: Colors.black,),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        height: 80,
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              alignment: Alignment(active.x, -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                height: 8,
                width: w * 0.2,
                color: active.color,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.map((item) {
                  return _buildFlareItem(item);
                  // return Container();
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final Color color;
  final double x;
  MenuItem({this.color, this.name, this.x});
}
