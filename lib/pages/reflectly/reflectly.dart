import 'package:flutter/material.dart';
import 'package:tryouts/pages/reflectly/data.dart';
import 'package:tryouts/pages/reflectly/data_modal.dart';

class ReflectlyPage extends StatefulWidget {
  @override
  _ReflectlyPageState createState() => _ReflectlyPageState();
}

class _ReflectlyPageState extends State<ReflectlyPage> {
  PageController _pageController = PageController(viewportFraction: 0.8);

  List<ReflectlyData> _data = reflectlyPageData;
  List<ReflectlyData> _filteredList = [];
  List<String> _tags = [];
  String activetag = 'favourites';
  int _currentPage = 0;

  List<Widget> _getTagsFRomList() {
    _tags = [];
    _data.forEach((item) {
      item.tags.forEach((tag) {
        if (!_tags.contains(tag)) {
          _tags.add(tag);
        }
      });
    });
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          'Your Stories',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      ..._tags.map((f) {
        return _buildButton(f);
      }).toList()
    ];
  }

  void _getData(String tag) {
    setState(() {
      _filteredList =
          _data.where((ReflectlyData page) => page.tags.contains(tag)).toList();
      activetag = tag;
    });
  }

  Widget _buildButton(tag) {
    Color color =
        tag == activetag ? Colors.purple : Colors.white.withOpacity(0);
    return FlatButton(
      color: color,
      child: Text(
        '#$tag',
        style: TextStyle(
          color:  tag == activetag ? Colors.white : Colors.black
        ),
      ),
      onPressed: () {
        _getData(tag);
      },
    );
  }

  Widget _buildTagView() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getTagsFRomList(),
      ),
    );
  }

  Widget _buildStoryPage(ReflectlyData data, bool isActive) {
    final double blur = isActive ? 30 : 0;
    final double offset = isActive ? 20 : 0;
    final double top = isActive ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data.image),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: blur,
              offset: Offset(offset, offset),
            )
          ]),
      child: Center(
        child: Text(
          data.title,
          style: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData('favourites');
    _pageController.addListener(() {
      int next = _pageController.page.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reflectly'),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: _filteredList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildTagView();
          } else if (index <= _filteredList.length) {
            bool active = index == _currentPage;
            return _buildStoryPage(_filteredList[index - 1], active);
          }
          return Container();
        },
      ),
    );
  }
}
