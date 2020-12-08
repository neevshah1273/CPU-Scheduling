import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './RRIOBT.dart';
import './Card.dart';
import './View.dart';

//FCFS page stateful class
class RR extends StatefulWidget {
  @override
  _RRState createState() => _RRState();
}

class _RRState extends State<RR> {
  var _counter = 0;
  double _avg_tat = 0, _avg_wt = 0;
  int TQ = 1;
  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];
  List<List<bool>> _readyq = [];
  List<String> _Na = [], _Re = [], _Ru = [], _Te = [];
  List<List<Widget>> _disdata = [], _disNum = [];

  void _Gant() {
    _cardv.clear();
    _cardvs.clear();
    _readyq.clear();

    List<int> RQ = [], bt, at;
    List<bool> inTQP;
    bt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt[i] = _data[i][1];
      at[i] = _data[i][0];
    }
    int ttnp = 0, _iofRQ = 0, _st = 0, _tt = -1;
    inTQP = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][1] > 0) flag = false;
      }

      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == _st && !inTQP[i] && _data[i][1] > 0) {
          RQ.add(i);
        }
        if (_data[i][0] == _st && inTQP[i] && _data[i][1] > 0) {
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      if (_st >= ttnp && _iofRQ < RQ.length) {
        if (_data[RQ[_iofRQ]][1] > 0) {
          _tt++;
          _readyq.add(List.filled(_counter, false));
          _cardv.add([0, 0, 0, 0]);
          _cardvs.add(['0', '0', '0', '0']);
          for (int j = _iofRQ + 1; j < RQ.length; ++j) {
            _readyq[_tt][RQ[j]] = true;
          }
          _cardv[_tt][0] = RQ[_iofRQ];
          int temp = min(TQ, _data[RQ[_iofRQ]][1]);
          _data[RQ[_iofRQ]][0] = _st + temp;
          _data[RQ[_iofRQ]][1] -= temp;
          _cardv[_tt][1] = _st;
          ttnp = _st + temp;
          _cardv[_tt][2] = ttnp;
          if (_data[RQ[_iofRQ]][1] == 0) {
            _cardv[_tt][3] = 1;
          }
          _data[RQ[_iofRQ]][2] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][3] = _data[RQ[_iofRQ]][2] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][4] = _data[RQ[_iofRQ]][3] - bt[RQ[_iofRQ]];
          _st++;
          for (int i = 0; i < 4; ++i)
            _cardvs[_tt][i] = _cardv[_tt][i].toString();
          //print(_tt);
        }
        _iofRQ++;
      } else {
        _st++;
      }
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt[i];
      _data[i][0] = at[i];
    }
  }

  void _viz() {
    int fct = 0;
    for (int i = 0; i < _counter; ++i) {
      fct = max(fct, _data[i][2]);
    }
    List<int> _ddata;
    _ddata = new List<int>.filled(fct + 1, -1);

    List<int> RQ = [], bt, at;
    List<bool> inTQP;
    bt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt[i] = _data[i][1];
      at[i] = _data[i][0];
    }
    int ttnp = 0, iofRQ = 0, st = 0;
    inTQP = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][1] > 0) flag = false;
      }
      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == st && !inTQP[i] && _data[i][1] > 0) {
          RQ.add(i);
          //print('here chance');
        }
        if (_data[i][0] == st && inTQP[i] && _data[i][1] > 0) {
          //print('object');
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      //print(st);
      //print(RQ);
      //print('----');
      if (st >= ttnp && iofRQ < RQ.length) {
        //print('st');
        //print(st);
        if (_data[RQ[iofRQ]][1] > 0) {
          int temp = min(TQ, _data[RQ[iofRQ]][1]);
          _data[RQ[iofRQ]][0] = st + temp;
          _data[RQ[iofRQ]][1] -= temp;
          for (int i = st + 1; i <= temp + st; ++i) {
            _ddata[i] = RQ[iofRQ];
          }
          ttnp = st + temp;
          _data[RQ[iofRQ]][2] = ttnp;
          inTQP[RQ[iofRQ]] = !inTQP[RQ[iofRQ]];
          _data[RQ[iofRQ]][3] = _data[RQ[iofRQ]][2] - at[RQ[iofRQ]];
          _data[RQ[iofRQ]][4] = _data[RQ[iofRQ]][3] - bt[RQ[iofRQ]];
          st++;
        }
        iofRQ++;
      } else {
        st++;
      }
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt[i];
      _data[i][0] = at[i];
    }

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

    view.TakeData('RR', _Na, _Re, _Ru, _Te, fct, _disdata, _disNum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view()),
    );
  }

  void _calculate() {
    List<int> RQ = [], bt, at;
    List<bool> inTQP;
    bt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt[i] = _data[i][1];
      at[i] = _data[i][0];
    }
    int ttnp = 0, iofRQ = 0, st = 0;
    inTQP = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][1] > 0) flag = false;
      }
      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == st && !inTQP[i] && _data[i][1] > 0) {
          RQ.add(i);
          //print('here chance');
        }
        if (_data[i][0] == st && inTQP[i] && _data[i][1] > 0) {
          //print('object');
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      //print(st);
      //print(RQ);
      //print('----');
      if (st >= ttnp && iofRQ < RQ.length) {
        //print('st');
        //print(st);
        if (_data[RQ[iofRQ]][1] > 0) {
          int temp = min(TQ, _data[RQ[iofRQ]][1]);
          _data[RQ[iofRQ]][0] = st + temp;
          _data[RQ[iofRQ]][1] -= temp;
          ttnp = st + temp;
          _data[RQ[iofRQ]][2] = ttnp;
          inTQP[RQ[iofRQ]] = !inTQP[RQ[iofRQ]];
          _data[RQ[iofRQ]][3] = _data[RQ[iofRQ]][2] - at[RQ[iofRQ]];
          _data[RQ[iofRQ]][4] = _data[RQ[iofRQ]][3] - bt[RQ[iofRQ]];
          st++;
        }
        iofRQ++;
      } else {
        st++;
      }
    }
    int _sum = 0;
    for (int i = 0; i < _counter; ++i) _sum += _data[i][3];
    _avg_tat = _sum / _counter;
    _sum = 0;
    for (int i = 0; i < _counter; ++i) _sum += _data[i][4];
    _avg_wt = _sum / _counter;
    for (int loc = 0; loc < _counter; ++loc) {
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
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
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt[i];
      _data[i][0] = at[i];
    }
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

  var fo = true;
  @override
  Widget build(BuildContext context) {
    if (fo) {
      _addrow();
      fo = false;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'RR',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'TQ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                  ),
                                  Container(
                                    width: 60,
                                    child: TextField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (val) {
                                        TQ = int.parse(val);
                                        setState(() {
                                          _calculate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        padding: EdgeInsets.all(30),
                        //color: Colors.lightBlue[400],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'I/O Device',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: false,
                                      onChanged: (t) {
                                        Navigator.pop(context);
                                        // Navigator.of(context).push(FCFSIOBT());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RRIOBT()),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                          alignment: Alignment.topRight,
                        ),
                        padding: EdgeInsets.all(30),
                        //color: Colors.deepPurple[800],
                      ),
                    )
                  ],
                ),
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
                      builder: (context) => (RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text(
                          'Delete Process',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _RemoveRow();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Row Deleted'),
                          ));
                        },
                      )),
                    ),
                    /*
                    child: (RaisedButton(
                      color: Colors.black,
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
                    )),*/
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