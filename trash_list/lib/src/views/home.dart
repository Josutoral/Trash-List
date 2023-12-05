import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  DateTime now = DateTime.now();

  List<Map<String, String>> wasteCollectionSchedule = [
    {'type': 'Carta e Cartone', 'date': '2023-12-03'},
    {'type': 'Rifiuto Secco Residuo', 'date': '2023-12-05'},
    {'type': 'Plastica e Metalli', 'date': '2023-12-07'},
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
  //https://icon-icons.com/icon/paper-boxes/69127
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAC04B),
      body: SafeArea(
          bottom: false,
          child: _body(),
        ),      
    );
  }

  _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _topBar(),
          _hourDay(),
          _nextTasks(),
          _content(),
        ],
      ),
    );
  }

  _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Benvenuto',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Josuè Toral',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onTap: () {
              print('inkwell');
            },
          ),
        ],
      ),
    );
  }

  _hourDay() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    String formattedDay = DateFormat('EEEE').format(now);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            formattedTime,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            formattedDay,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  _nextTasks() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Your next scheduled task starts in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Color(0xFFFFC653),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '1:12:34',
                      style: TextStyle(
                        color: Color(0xFFFFC653),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  print('view');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(
                  'View',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _content() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Color(0xFFFEFCF8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _filters(),
            Expanded(
            child: ListView.builder(
              itemCount: wasteCollectionSchedule.length,
              //separatorBuilder: (context, index) => Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                return _buildListItem(wasteCollectionSchedule[index]);
              },
            ),
          ),
            //_progress(),
          ],
        ),
      ),
    );
  }

  _filters() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            color: Color(0xFFFEF2D9),
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {
              print('today');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Oggi',
              style: TextStyle(
                color: Color(0xFF606060),
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('this week');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Questa settimana',
              style: TextStyle(
                color: Color(0xFFB9B9B9),
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('next week');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Prossima settimana',
              style: TextStyle(
                color: Color(0xFFB9B9B9),
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
        ],
      ),
    );
  }

  _tasks() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        child: PageView(
          children: <Widget>[
            _taskView(
              'All',
              '8',
              Color(0xFFE6F3EA),
              Color(0xFF7FBDA4),
              'assets/all.jpg',
            ),
            _taskView(
              'Work',
              '3',
              Color(0xFFD8E0FE),
              Color(0xFF18137C),
              'assets/work.jpg',
            ),
            _taskView(
              'Home',
              '5',
              Color(0xFFFDECD4),
              Color(0xFFFE5047),
              'assets/home.jpg',
            ),
          ],
        ),
      ),
    );
  }

  

  _tasksListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return _taskView(
          'All',
          '8',
          Color(0xFFE6F3EA),
          Color(0xFF7FBDA4),
          'assets/all.jpg',
        );
      },
    );
  }

  Widget _buildListItem(Map<String, String> item) {
  IconData iconData;
  Color iconColor;

  switch (item['type']) {
    case 'Carta e Cartone':
      iconData = Icons.ac_unit;
      iconColor = Colors.green;
      break;
    case 'Rifiuto Secco Residuo':
      iconData = Icons.delete_outline;
      iconColor = Colors.grey;
      break;
    case 'Plastica e Metalli':
      iconData = Icons.eco;
      iconColor = Colors.brown;
      break;
    default:
      iconData = Icons.error_outline;
      iconColor = Colors.red;
  }

  return Container(
    height: 75,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Align(
      alignment: Alignment.center,
      child:
    ListTile(
      leading: Icon(iconData, color: iconColor),
      title: Text(
        item['type']!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      
      trailing: Text('20:00'),
    )));
}

  _taskView(
    String taskName,
    String taskCount,
    Color bgColor,
    Color txtBadgeColor,
    String bgImage,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
        Positioned(
          bottom: 35,
          left: 60,
          child: Text(
            taskName,
            style: TextStyle(
              color: txtBadgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 40,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Text(
              taskCount,
              style: TextStyle(
                color: txtBadgeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _progress() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Today\'s progress'),
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Color(0xFFFEF2D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 132),
              decoration: BoxDecoration(
                color: Color(0xFFFFC653),
                // borderRadius: BorderRadius.circular(10),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                '68%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    Paint paintRectangle = Paint();
    paintRectangle.color = Color(0xFFFFD25B);
    Paint paintCircle = Paint();
    paintCircle.color = Color(0xFFFFC653);

    Path patternRectangle = Path();
    for (var i = 0; i < 100; i++) {
      double top = 10.0;

      if (i > 0) {
        top = 20.0 + 75 * i;
      }

      if (i % 2 == 0) {
        patternRectangle.addRect(Rect.fromLTWH(width / 2.12, top, 75, 75));
        patternRectangle.addRect(Rect.fromLTWH(width * 0.02, top, 75, 75));
        patternRectangle.addRect(Rect.fromLTWH(width * 0.92, top, 75, 75));
      } else {
        patternRectangle.addRect(Rect.fromLTWH(width / 4.12, top, 75, 75));
        patternRectangle.addRect(Rect.fromLTWH(width * 0.7, top, 75, 75));
      }
    }
    patternRectangle.close();

    Path patternCircle = Path();
    for (var i = 0; i < 100; i++) {
      double top = 25;

      if (i > 0) {
        top = height / 10 * i;
      }

      if (i % 2 == 0) {
        patternCircle.addOval(Rect.fromLTWH(width / 2, top, 50, 50));
        patternCircle.addOval(Rect.fromLTWH(width * 0.05, top * 0.6, 50, 50));
        patternCircle.addOval(Rect.fromLTWH(width * 0.85, top * 0.8, 60, 60));
      } else {
        patternCircle.addOval(Rect.fromLTWH(width / 4, top, 75, 75));
        patternCircle.addOval(Rect.fromLTWH(width * 0.6, top * 0.9, 75, 75));
        patternCircle.addOval(Rect.fromLTWH(width * 0.26, top * 0.4, 30, 30));
      }
    }
    patternCircle.close();

    canvas.drawPath(patternRectangle, paintRectangle);
    canvas.drawPath(patternCircle, paintCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
