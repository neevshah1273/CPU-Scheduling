import 'dart:math';

import 'package:flutter/material.dart';
import './SRTFIOBT.dart';
import './Card.dart';
import './View.dart';

//SRTF page stateful class
class SRTF extends StatefulWidget {
  @override
  _SRTFState createState() => _SRTFState();
}

class _SRTFState extends State<SRTF> {
  var _counter = 0;
  double _avg_tat = 0, _avg_wt = 0;

  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];
  List<List<bool>> _readyq = [];
  List<String> _Na = [], _Re = [], _Ru = [], _Te = [];
  List<List<Widget>> _disdata = [], _disNum = [];

  void _viz() {
    int fct = 0;
    for (int i = 0; i < _counter; ++i) {
      fct = max(fct, _data[i][2]);
    }
    List<int> _ddata;
    _ddata = new List<int>.filled(fct + 1, -1);

    int cal = 0, st = 0;
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      var mn = 100, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] < mn && !vis[i] && st >= _data[i][0]) {
          mn = _data[i][1];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      if (_data[loc][1] > 0) {
        st++;
        _ddata[st] = loc;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
    }
    for (int i = 0; i < _counter; ++i) _data[i][1] = val[i];

    List<int> _Running;
    _Running = new List<int>.filled(fct + 1, -1);
    for (int i = 0; i < fct; ++i) {
      if (_ddata[i] == _ddata[i + 1]) {
        _Running[i] = _ddata[i];
      }
    }
    _disdata.clear();
    _disdata.add([]);
    _disNum.clear();
    _disNum.add([]);
    for (int i = 1; i <= fct; ++i) {
      _disdata.add([]);
      _disNum.add(
        [
          Container(
            height: 30,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ],
      );
      for (int j = 1; j <= i; ++j) {
        String temp = 'P' + _ddata[j].toString();
        if (_ddata[j] == -1) temp = ' ';
        if (j + 1 <= i && _ddata[j] == _ddata[j + 1]) continue;
        _disNum[i].add(
          Container(height: 70),
        );
        _disNum[i].add(
          Container(
            height: 30,
            child: Text(
              j.toString(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        );
        if (j == i && j + 1 <= fct && _ddata[j] == _ddata[j + 1]) {
          _disdata[i].add(
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.red),
                  right: BorderSide(color: Colors.red),
                  top: BorderSide(color: Colors.red),
                ),
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  temp,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          );
          continue;
        }
        _disdata[i].add(
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                temp,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        );
      }
    }
    _Na.clear();
    _Re.clear();
    _Ru.clear();
    _Te.clear();
    for (int i = 0; i <= fct; ++i) {
      String tempNa = '', tempRe = '', tempTe = '', tempRu = '';
      for (int j = 0; j < _counter; ++j) {
        if (_data[j][0] > i) {
          if (tempNa.isEmpty)
            tempNa += 'P' + j.toString();
          else
            tempNa += ', P' + j.toString();
        } else if (_data[j][2] <= i) {
          if (tempTe.isEmpty)
            tempTe += 'P' + j.toString();
          else
            tempTe += ', P' + j.toString();
        } else if (_Running[i] == j) {
          tempRu += 'P' + j.toString();
        } else {
          if (tempRe.isEmpty)
            tempRe += 'P' + j.toString();
          else
            tempRe += ', P' + j.toString();
        }
      }
      _Na.add(tempNa);
      _Te.add(tempTe);
      _Re.add(tempRe);
      _Ru.add(tempRu);
    }

    view.TakeData('SRTF', _Na, _Re, _Ru, _Te, fct, _disdata, _disNum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view()),
    );
  }

  void _Gant() {
    _cardv.clear();
    _cardvs.clear();
    _readyq.clear();
    _cardv.add([0, 0, 0, 0]);
    _cardvs.add(['0', '0', '0', '0']);
    int cal = 0, st = 0, _t = 0;
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      _readyq.add(List.filled(_counter, false));
      var mn = 100, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] < mn && !vis[i] && st >= _data[i][0]) {
          mn = _data[i][1];
          loc = i;
          f = false;
        }
        /*
        if(!vis[i] && st >= _data[i][0]){
          _readyq[_t][i]=true;
        }*/
      }
      if (f) {
        st++;
        //_readyq.removeLast();
        continue;
      }
      if (_data[loc][1] > 0) {
        if (_t == 0 &&
            _cardv[_t][0] == 0 &&
            _cardv[_t][1] == 0 &&
            _cardv[_t][2] == 0) {
          _cardv[_t][0] = loc;
          _cardv[_t][1] = st;
          _cardv[_t][2] = st + 1;
          for (var i = 0; i < _counter; ++i) {
            if (!vis[i] && st >= _data[i][0]) {
              _readyq[_t][i] = true;
            }
          }
        } else if (_cardv[_t][0] == loc) {
          _cardv[_t][2]++;
        } else {
          _t++;
          _cardv.add([0, 0, 0, 0]);
          _cardvs.add(['0', '0', '0', '0']);
          _cardv[_t][0] = loc;
          _cardv[_t][1] = st;
          _cardv[_t][2] = st + 1;
          for (var i = 0; i < _counter; ++i) {
            if (!vis[i] && st >= _data[i][0]) {
              _readyq[_t][i] = true;
            }
          }
        }
        st++;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        _cardv[_t][3] = 1;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
      for (int i = 0; i < 4; ++i) _cardvs[_t][i] = _cardv[_t][i].toString();
    }
    for (int i = 0; i < _counter; ++i) _data[i][1] = val[i];
  }

  void _calculate() {
    int cal = 0, st = 0, _t = 0;
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      var mn = 100, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] < mn && !vis[i] && st >= _data[i][0]) {
          mn = _data[i][1];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      if (_data[loc][1] > 0) {
        st++;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
      int _sum = 0;
      for (int i = 0; i < _counter; ++i) _sum += _data[i][3];
      _avg_tat = _sum / _counter;
      _sum = 0;
      for (int i = 0; i < _counter; ++i) _sum += _data[i][4];
      _avg_wt = _sum / _counter;
      int t = loc;
      _rowList[loc] = DataRow(cells: <DataCell>[
        DataCell(
            Text('P' + t.toString(), style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][2], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][3], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
      ]);
    }
    for (int i = 0; i < _counter; ++i) _data[i][1] = val[i];
  }

  void _addrow() {
    setState(() {
      var t = _counter;
      _counter++;
      _data.add([0, 0, 0, 0, 0]);

      _datas.add(['0', '0', '0', '0', '0']);

      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text('P' + (_counter - 1).toString(),
            style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][2], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][3], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
      ]));
    });
  }

  void _RemoveRow() {
    setState(() {
      _counter--;
      _rowList.removeLast();
      _data.removeLast();
      _datas.removeLast();
      _calculate();
    });
  }

  var f = true;
  @override
  Widget build(BuildContext context) {
    if (f) {
      _addrow();
      f = false;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'SRTF',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Padding(
                child: Align(
                  child: Text(
                    'I/O Device',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  alignment: Alignment.topRight,
                ),
                padding: EdgeInsets.only(right: 30),
              ),
              Padding(
                child: Align(
                  child: Switch(
                      value: false,
                      onChanged: (t) {
                        Navigator.pop(context);
                        // Navigator.of(context).push(FCFSIOBT());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SRTFIOBT()),
                        );
                      }),
                  alignment: Alignment.topRight,
                ),
                padding: EdgeInsets.only(right: 30),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('P',
                                style: TextStyle(color: Colors.white)),
                            numeric: false),
                        DataColumn(
                            label: Text('AT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('BT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('CT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('TAT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('WT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                      ],
                      rows: _rowList,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: (RaisedButton(
                      onPressed: _addrow,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Add Process',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Builder(
                      builder: (context)=> (RaisedButton
                        ( color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text(
                          'Delete Process',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: (){
                          _RemoveRow();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Row Deleted'),
                              )
                          );
                        },
                      )
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Gantt Chart',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _Gant();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CARD(_cardvs, _readyq),
                            ));
                      },
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Visulization',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _viz,
                    )),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.fromLTRB(60, 25, 0, 0),
                    child: Text('AVg. TAT = ' + _avg_tat.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.fromLTRB(100, 25, 0, 0),
                    child: Text('AVg. WT = ' + _avg_wt.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Container(height: 700),
            ],
          ),
        ));
  }
}