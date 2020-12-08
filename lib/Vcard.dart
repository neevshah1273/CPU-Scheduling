import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class customExpansionTile extends StatefulWidget {
  int index;
  List lls, rqqq;
  String _rq, _tq;
  customExpansionTile(int index, List lls, List rqqq, String _rq, String _tq) {
    this.index = index;
    this.lls = lls;
    this.rqqq = rqqq;
    this._rq = _rq;
    this._tq = _tq;
  }

  @override
  customExpansionTilestate createState() =>
      customExpansionTilestate(index, lls, rqqq, _rq, _tq);
}

class customExpansionTilestate extends State {
  int i;
  List ls = [], rql = [];
  String _r, _t;
  customExpansionTilestate(
      int index, List lls, List rqqq, String rq, String tq) {
    i = index;
    ls = lls;
    rql = rqqq;
    _r = rq;
    _t = tq;
    //print('object');
  }

  Color _textcolor = Colors.black;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: isExpanded
          ? Icon(
        FontAwesomeIcons.chevronCircleUp,
        color: Colors.black,
      )
          : Icon(FontAwesomeIcons.chevronCircleDown),
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                  //height: 100,
                  child: Text(
                    'Process:' + ls[i][0],
                    style: TextStyle(
                      fontSize: 20,
                      color: _textcolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                  //height: 50,
                  child: Text(
                    'Start Time: ' + ls[i][1],
                    style: TextStyle(
                      fontSize: 20,
                      color: _textcolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                  //height: 50,
                  child: Text(
                    'End Time: ' + ls[i][2],
                    style: TextStyle(
                      fontSize: 20,
                      color: _textcolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                //height: 50,
                child: Text(
                  'Ready Queue:' + _r,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                //height: 50,
                child: Text(
                  'Finished Queue:' + _t,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      onExpansionChanged: (bool expanding) =>
          setState(() => this.isExpanded = expanding),
    );
  }
}