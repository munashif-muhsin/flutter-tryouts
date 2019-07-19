import 'package:flutter/material.dart';

class SkeleTonText extends StatefulWidget {
  @override
  _SkeleTonTextState createState() => _SkeleTonTextState();
}

class _SkeleTonTextState extends State<SkeleTonText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  Widget _buildAnimatedSkeletenText(double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(gradientPosition.value, 0),
            end: Alignment(-1, 0),
            colors: [Colors.black12, Colors.black26, Colors.black12]),
      ),
    );
  }

  Widget _buildListItem() {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black12,
            height: 100,
            width: 100,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAnimatedSkeletenText(
                    (MediaQuery.of(context).size.width * 0.9) - 100, 20),
                _buildAnimatedSkeletenText(
                    (MediaQuery.of(context).size.width * 0.8) - 100, 20),
                _buildAnimatedSkeletenText(
                    (MediaQuery.of(context).size.width * 0.7) - 100, 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildList() {
    List<Widget> list = [];
    int count = 5;
    for (var i = 0; i < count; i++) {
      list.add(_buildListItem());
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skeleton Text Loading Animation'),
      ),
      body: ListView(
        children: _buildList(),
      ),
    );
  }
}
