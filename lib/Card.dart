import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './Vcard.dart';

class CARD extends StatefulWidget {
  List ll = [];
  List rq = [];
  CARD(List _cardvs, List _readyq) {
    ll = _cardvs;
    rq = _readyq;
  }

  @override
  State<StatefulWidget> createState() {
    return CARDstate(ll, rq);
  }
}

class CARDstate extends State {
  List ls = [];
  List rqq = [];
  CARDstate(ll, rq) {
    //print("Hello from here");
    ls = ll;
    rqq = rq;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VISulizaTiON'),
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (var i = 0; i < ls.length; i++) Vcard(i, ls, rqq)
              ],
            ),
          )),
    );
  }
}

class Vcard extends StatelessWidget {
  Color _textcolor = Colors.black;

  var index;
  List lls;
  List rqqq;
  String _rq;
  String _tq;
  Vcard(int i, List ls, List rqq) {
    index = i;
    lls = ls;
    rqqq = rqq;
    _rq = "";
    _tq = "";
    int c = rqqq[i].length;
    for (int j = 0; j < c; j++) {
      if (rqq[i][j] && ls[i][0] != j) {
        if (j.toString() != lls[index][0]) {
          print(j);
          print(lls[index][0]);
          //print('---');
          _rq += ' P' + j.toString();
        }
      }
    }
    //print('********');

    for (var j = 0; j < index; ++j)
      if (lls[j][3] == '1') _tq += ' P' + lls[j][0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          //height: 250,

          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  customExpansionTile(index, lls, rqqq, _rq, _tq),
                ],
              )),
        ),
        color: lls[index][3] == '1'
            ? Colors.green
            : lls[index][3] == '2'
            ? Colors.grey
            : Colors.red,
        //lls[index][3]==2? Colors.grey:
      ),
    );
  }
}